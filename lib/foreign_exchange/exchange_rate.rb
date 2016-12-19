require 'nokogiri'

module ForeignExchange
  class ExchangeRate
    class << self
      attr_accessor :rates


      def at(date, base_currency, counter_currency)
        date_key = date.strftime("%Y-%m-%d")
        raise UnknownDate unless rates.key?(date_key)
        raise NoCurrencyData unless rates[date_key].key?(base_currency) && rates[date_key].key?(counter_currency)

        base_rate = rates[date_key][base_currency]
        counter_rate = rates[date_key][counter_currency]

        return (1 / base_rate) * (counter_rate / 1)
      end

      def parse_rates(rates_path = nil)
        rates_file_path = rates_path || File.join("storage", "rates.xml")
        raise NoRatesFound unless File.exists?(rates_file_path)

        self.rates = {}

        rates_document = File.open(rates_file_path) { |f| Nokogiri::XML(f) }
        daily_rates = rates_document.xpath("//xmlns:Cube[@time]")
        daily_rates.each do |daily_rate|
          date = daily_rate.attribute("time").value

          rates[date] = {}
          currencies = daily_rate.xpath(".//xmlns:Cube[@rate]")
          currencies.each do |currency|
            code = currency.attribute("currency").value
            rate = currency.attribute("rate").value

            rates[date][code] = rate.to_f
          end
        end
      end

      def currencies
        rates.first[1].keys
      end
    end

    class UnknownDate < StandardError; end
    class NoCurrencyData < StandardError; end
    class NoRatesFound < StandardError; end
  end
end