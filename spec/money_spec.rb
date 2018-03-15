require 'spec_helper'

describe Money do
  describe '*' do
    five = described_class.doller(5)
    it do
      expect(described_class.doller(10)).to eq five * 2
      expect(described_class.doller(15)).to eq five * 3
    end
  end

  describe '==' do
    it do
      expect(described_class.doller(5)).to eq described_class.doller(5)
      expect(described_class.doller(5)).not_to eq described_class.doller(6)
      expect(described_class.franc(5)).not_to eq described_class.doller(5)
    end
  end

  describe 'currency' do
    it do
      expect(described_class.doller(1).currency).to eq 'USD'
      expect(described_class.franc(1).currency).to eq 'CHF'
    end
  end

  describe 'simple addition' do
    let(:five) { described_class.doller(5) }
    let(:sum) { five + five }
    let(:bank) { Bank.new }
    let(:reduced) { bank.reduce(sum, 'USD') }

    it do
      expect(reduced).to eq described_class.doller(10)
    end
  end

  describe 'plus returns sum' do
    let(:five) { described_class.doller(5) }
    let(:result) { five + five }
    let(:sum) { result }

    it do
      expect(five).to eq sum.augend
      expect(five).to eq sum.addend
    end
  end

  describe 'reduce sum' do
    let(:sum) { Sum.new(described_class.doller(3), described_class.doller(4)) }
    let(:bank) { Bank.new }
    let(:result) { bank.reduce(sum, 'USD') }

    it do
      expect(described_class.doller(7)).to eq result
    end
  end

  describe 'reduce money' do
    let(:bank) { Bank.new }
    let(:result) { bank.reduce(described_class.doller(1), 'USD') }

    it do
      expect(result).to eq described_class.doller(1)
    end
  end

  describe 'reduce money different currency' do
    let(:bank) do
      bank = Bank.new
      bank.add_rate('CHF', 'USD', 2)
      bank
    end
    let(:result) { bank.reduce(described_class.franc(2), 'USD') }

    it do
      expect(result).to eq described_class.doller(1)
    end
  end

  describe 'identity rate' do
    it do
      expect(Bank.new.rate('USD', 'USD')).to eq 1
    end
  end
end
