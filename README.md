# TickerPicker

[![Build Status](https://travis-ci.org/mustafaturan/tickerpicker.png)](https://travis-ci.org/mustafaturan/tickerpicker) [![Code Climate](https://codeclimate.com/github/mustafaturan/tickerpicker.png)](https://codeclimate.com/github/mustafaturan/tickerpicker)

A generalized ticker picker for crypto currency stock exchanges.

## Installation

Add this line to your application's Gemfile:

    gem 'tickerpicker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tickerpicker

## Usage
Register stocks from avaliable stock list

    TickerPicker::Ticker.register "mtgox"
    TickerPicker::Ticker.register "btce"
    
Or register multiple stocks:

    TickerPicker::Ticker.register_list ["mtgox", "btce", "bitstamp"]

Get prices from the stock's specific market:

    prices_mtgox_usd = TickerPicker::Ticker.get_prices 'mtgox', 'btc_usd'
    prices_bitstamp_usd = TickerPicker::Ticker.get_prices 'bitstamp', 'btc_usd'
    
Print all prices as hash:

    puts prices_mtgox_usd.to_dh
    
Print specific info from prices:

    puts prices_mtgox_usd.ask
    puts prices_mtgox_usd.bid
    puts prices_mtgox_usd.last
    puts prices_mtgox_usd.timestamp
    puts prices_mtgox_usd.currency

Get prices from the stock

    mtgox_markets = TickerPicker::Ticker.get_all_stock_prices 'mtgox'

Get prices from all avaliable stock-markets

    all_stock_markets = TickerPicker::Ticker.get_all_stock_market_prices

## Configuration (optional & advanced)
Set your stocks.yml file path if you need to modify default

    TickerPicker.configure  do |config|
      config.stock_configuration_file = "#{File.dirname(__FILE__)}/stocks.yml" # your stocks.yml path
    end

Add new markets to the stocks(sample: your stocks.yml)

    bitstamp:
      btc_usd:
        url: 'https://www.bitstamp.net/api/ticker/'
        currency: 'USD'
    btce:
      btc_usd:
        url: 'https://btc-e.com/api/2/btc_usd/ticker'
        currency: 'USD'
      btc_eur:
        url: 'https://btc-e.com/api/2/btc_eur/ticker'
        currency: 'EUR'
    btcturk:
      btc_try:
        url: 'https://btcturk.com/api/ticker/'
        currency: 'TRY'
    mtgox:
      btc_usd:
        url: 'http://data.mtgox.com/api/2/BTCUSD/money/ticker_fast'
        currency: 'USD'
      btc_eur:
        url: 'http://data.mtgox.com/api/2/BTCEUR/money/ticker_fast'
        currency: 'EUR'


## Available Stocks

BTC-E (btce)

BITSTAMP (bitstamp)

BTCTURK (btcturk)

MTGOX (mtgox)

## Donations
I accept donations :)
https://blockchain.info/address/182dMXGmdVYgv6m1qXq3tncoPfDfBmvtBM

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
