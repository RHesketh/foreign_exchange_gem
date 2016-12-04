module ForeignExchange
  class RateDownloader
    def self.download
      require 'pry'; binding.pry
      uri = URI(ForeignExchange.configuration.rates_url)

      return nil
    end
  end
end