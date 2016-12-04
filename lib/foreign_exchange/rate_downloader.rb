require "open-uri"

module ForeignExchange
  class RateDownloader
    def self.download
      raise ConfigError.new("Rates url must be defined before rates can be downloaded") unless ForeignExchange.configuration.rates_url.is_a?(String)

      uri = URI(ForeignExchange.configuration.rates_url)
      local_file = File.join("storage", "rates.xml")

      File.open(local_file, 'wb') do |file|
        file.write open(uri).read
      end

      return nil
    end
  end
end