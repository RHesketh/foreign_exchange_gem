require 'foreign_exchange'

module ForeignExchange
  describe ExchangeRate do
    describe "#parse_rates" do
      # Dummy file contains only USD and JPY rates for 2016-12-01
      let(:dummy_data) { File.join("spec", "sample_data", "dummy.xml")}

      it "Throws an error if there is no file located at storage/rates.xml" do
        local_file_path = File.join("storage", "rates.xml")
        allow(File).to receive(:exists?).and_call_original
        allow(File).to receive(:exists?).with(local_file_path).and_return(false)

        expect{ExchangeRate.parse_rates}.to raise_error(ExchangeRate::NoRatesFound)
      end

      it "creates an entry for each date in the XML file" do
        ExchangeRate.parse_rates(dummy_data)

        expect(ExchangeRate.rates.key?('2016-12-01')). to be true
        expect(ExchangeRate.rates.key?('2016-11-30')). to be false
      end

      it "creates an entry for each rate per day in the XML file" do
        ExchangeRate.parse_rates(dummy_data)

        daily_rates = ExchangeRate.rates['2016-12-01']

        expect(daily_rates["USD"]).to eq 1.0642
        expect(daily_rates["JPY"]).to eq 121.2
      end
    end

    describe "#at" do
      before(:each) do
        ExchangeRate.rates = {
          '2016-12-02' => {
            'USD' => 2.0,
            'GBP' => 0.5
          }
        }
      end

      it "Raises an error if asked for a date that is not in storage" do
        unknown_date = Date.parse('2016-12-01')

        expect{ExchangeRate.at(unknown_date, "USD", "GBP")}.to raise_error ExchangeRate::UnknownDate
      end

      it "Raises an error if asked for a base currency that we have no rate for" do
        date = Date.parse('2016-12-02')

        expect{ExchangeRate.at(date, "???", "GBP")}.to raise_error ExchangeRate::NoCurrencyData
      end

      it "Raises an error if asked for a counter currency that we have no rate for" do
        date = Date.parse('2016-12-02')

        expect{ExchangeRate.at(date, "USD", "???")}.to raise_error ExchangeRate::NoCurrencyData
      end

      it "calculates the exchange rate between two currencies" do
        date = Date.parse('2016-12-02')

        expect(ExchangeRate.at(date, "USD", "GBP")).to eq(0.25)
        expect(ExchangeRate.at(date, "GBP", "USD")).to eq(4)
      end

      it "has an implicit 'EUR' currency of rate 1.0" do
        date = Date.parse('2016-12-02')

        expect(ExchangeRate.at(date, "EUR", "USD")).to eq(2.0)
        expect(ExchangeRate.at(date, "EUR", "GBP")).to eq(0.5)
      end
    end

    describe "#currencies" do
      describe "When currency data has been loaded" do
        before(:each) do
          ExchangeRate.rates = {
            '2016-12-02' => {
              'USD' => 2.0,
              'GBP' => 0.5
            }
          }
        end

        it "Returns an array for every currency we have data for" do
          # Includes an implicit "EUR" currency
          expect(ExchangeRate.currencies).to eq ["EUR", "USD", "GBP"]
        end
      end

      describe "When currency data has not been loaded" do
        before(:each) do
          ExchangeRate.rates = {}
        end

        it "Returns a blank array" do
          expect(ExchangeRate.currencies).to eq([])
        end
      end
    end
  end
end