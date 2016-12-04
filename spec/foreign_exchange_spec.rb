require 'foreign_exchange'

describe ForeignExchange do
  describe "#configure" do
    let(:test_url) { "http://example.com" }

    before(:each) do
      ForeignExchange.configure do |config|
        config.rates_url = test_url
      end
    end

    it "rates_url defines the URL of the XML file to be downloaded" do
      expect(URI).to receive(:parse).with(test_url).and_call_original

      ForeignExchange::RateDownloader.download
    end

    after(:each) do
      ForeignExchange.reset
    end
  end

  describe "#reset" do
    before(:each) do
      ForeignExchange.configure do |config|
        config.rates_url = "A string"
      end
    end

    it "resets the configuration" do
      ForeignExchange.reset

      config = ForeignExchange.configuration

      expect(config.rates_url).to eq(nil)
    end
  end
end