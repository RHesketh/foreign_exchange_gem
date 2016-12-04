require 'foreign_exchange'

describe ForeignExchange::RateDownloader do
  describe "#configure" do
    let(:test_url) { "http://example.com" }

    before(:each) do
      ForeignExchange::RateDownloader.configure do |config|
        config.rates_url = test_url
      end
    end

    xit "rates_url defines the URL of the XML file to be downloaded" do
      uri = URI(test_url)
      require 'pry'; binding.pry
      expect{}
    end
  end

  describe "#download" do
    it "returns nil if there were no errors in execution" do
      expect(ForeignExchange::RateDownloader.download).to be_nil
    end
  end
end