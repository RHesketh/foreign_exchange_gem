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

The rate data is downloaded whenever `RateDownloader.download` is called. Before downloading, the url of the rates data must be set using a configure block, like this:
```
ForeignExchange.configure do |config|
  config.rates_url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
end
```

The easiest way to download rate data is to create a rake task. Here is a basic rake task that could be automatically run on a schedule:

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

## Development Notes
### Gem configuration
I did not want this gem to depend on a specific framework or to make assumptions about the environment where it would be used. The configuration and rates downloading are all handled internally so that they can be called from any kind of Ruby project.

### Rates storage
I had considered that the spec might call for historical data to be stored going back a long time, beyond the days in the latest XML file. I decided that this would be a lot of effort to implement in the time given, especially considering the configuration implications of a gem that requires a database but does not depend on Rails or similar. A locally stored XML file seemed like a good solution, although a read-only SQLite DB would also be an option if the data had a more complicated structure or could benefit from being queried.

## License

All code, text and images found in this repository are licensed using the [Unlicense](http://unlicense.org/) and are free to use for whatever you like.