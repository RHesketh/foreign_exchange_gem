require 'foreign_exchange'

module ForeignExchange
  describe RateDownloader do
    let(:dummy_file) {File.open(File.join("spec", "sample_data", "dummy.xml"))}

    before(:each) do
      allow(RateDownloader).to receive(:open) do |url|
        dummy_file
      end
    end

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

      it "Downloads a file and stores it locally as storage/rates.xml" do
        RateDownloader.download

        local_file_path = File.join("storage", "rates.xml")

        expect(File.exists?(local_file_path)).to be true
      end

      after(:each) do
        ForeignExchange.reset
      end
    end
  end
end