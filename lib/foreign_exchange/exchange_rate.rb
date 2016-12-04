module ForeignExchange
  class ExchangeRate
    class << self
      attr_accessor :rates
    end

    def self.at(date, base_currency, counter_currency)
      date_key = date.strftime("%Y-%m-%d")
      raise UnknownDate unless rates.key?(date_key)
      raise NoCurrencyData unless rates[date_key].key?(base_currency) && rates[date_key].key?(counter_currency)

      base_rate = rates[date_key][base_currency]
      counter_rate = rates[date_key][counter_currency]

      return (1 / base_rate) * (counter_rate / 1)
    end

    class UnknownDate < StandardError; end
    class NoCurrencyData < StandardError; end
  end
end