require "foreign_exchange/version"
require "foreign_exchange/configuration"
require "foreign_exchange/rate_downloader"
require "foreign_exchange/exchange_rate"

module ForeignExchange
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class ConfigError < StandardError; end
end