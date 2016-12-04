require 'foreign_exchange'

module ForeignExchange
  describe ExchangeRate do
    before(:each) do
      ExchangeRate.rates = {
        '2016-12-02' => {
          'USD' => 2.0,
          'GBP' => 0.5
        }
      }
    end

    describe "#at" do
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
    end
  end
end