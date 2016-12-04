require 'foreign_exchange'

module ForeignExchange
  describe RateDownloader do
    describe "#download" do
      it "raises an error if called when the rates_url has not been set" do
        expect{RateDownloader.download}.to raise_error(ConfigError)
      end
    end

    context "When the rates URL has been specified" do
      before (:each) do
        ForeignExchange.configuration.rates_url = "http://example.com"
      end

      it "does not raise an error" do
        expect{RateDownloader.download}.not_to raise_error
      end

      after(:each) do
        ForeignExchange.reset
      end
    end
  end
end