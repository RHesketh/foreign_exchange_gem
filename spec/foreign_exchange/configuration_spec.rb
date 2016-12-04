require 'foreign_exchange'

module ForeignExchange
  describe Configuration do
    describe "#rates_url" do
      it "default value is nil" do
        expect(Configuration.new.rates_url).to eq (nil)
      end
    end

    describe "#rates_url=" do
      it "can set value" do
        config = Configuration.new
        config.rates_url = "http://example.com"
        expect(config.rates_url).to eq("http://example.com")
      end
    end
  end
end