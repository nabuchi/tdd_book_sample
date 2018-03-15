require 'pry'

class Money < Expression
  attr_accessor :amount
  attr_reader :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  class << self
    def doller(amount)
      new(amount, 'USD')
    end

    def franc(amount)
      new(amount, 'CHF')
    end
  end

  def *(other)
    self.class.new(@amount * other, @currency)
  end

  def +(other)
    Sum.new(self, other)
  end

  def reduce(bank, to)
    rate = bank.rate(@currency, to)
    self.class.new(@amount / rate, to)
  end

  def ==(other)
    @amount == other.amount && @currency == other.currency
  end

  def to_s
    "#{@amount} #{@currency}"
  end
end
