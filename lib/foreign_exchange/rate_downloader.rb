module ForeignExchange
  class RateDownloader
    def self.download
      raise ConfigError.new("Rates url must be defined before rates can be downloaded") unless ForeignExchange.configuration.rates_url.is_a?(String)

      uri = URI(ForeignExchange.configuration.rates_url)

      return nil
    end
  end
end