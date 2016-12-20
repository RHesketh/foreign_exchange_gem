# Foreign Exchange
Foreign Exchange Web Frontend is a small Ruby gem allowing the downloading and checking of foreign exchange rate data. It can be included in a Rails project but does not require Rails.

## Installation

Include the gem in your application's Gemfile

`gem 'foreign_exchange', path: 'your/local/gem/path'`

When your application starts up, the rates must be loaded into memory. Add some code that will run every time your application starts (this could be in an initializer for a Rails project) and execute the following code:

```
using 'foreign_exchange'

ForeignExchange::ExchangeRate.parse_rates
```

You'll need to tell the gem how to download your rate data before you can use it. I suggest a rake task along the following lines:

```
require 'foreign_exchange'

ForeignExchange.configure do |config|
  config.rates_url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
end

namespace :rates do
  desc "Downloads the latest rates from the URL specified"
  task download: :environment do
    ForeignExchange::RateDownloader.download
  end
end
```

## Usage
Once the gem has been loaded, you can use it by calling:

`ForeignExchange::ExchangeRate.at([date], [from_currency], [to_currency])`

For example:

```
ForeignExchange::ExchangeRate.at(Date.today, 'USD', 'GBP')
> 1.4244224426
```

## Tests

The project contains integration and unit tests written in RSpec, they can be run using:

`rspec spec`

## License

All code, text and images found in this repository are licensed using the [Unlicense](http://unlicense.org/) and are free to use for whatever you like.