# TickerPicker

[![Build Status](https://travis-ci.org/mustafaturan/tickerpicker.png)](https://travis-ci.org/mustafaturan/tickerpicker) [![Code Climate](https://codeclimate.com/github/mustafaturan/tickerpicker.png)](https://codeclimate.com/github/mustafaturan/tickerpicker)
[![Gem Version](https://badge.fury.io/rb/tickerpicker.png)](http://badge.fury.io/rb/tickerpicker)

A generalized ticker picker library for cryto currencies like #BTC(bitcoin), #LTC(litecoin) in world stock markets.

## Installation

Add this line to your application's Gemfile:

    gem 'tickerpicker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tickerpicker

## Usage
Register stock-market sources using stock.yml file.

Get prices from the stock's specific market:

    prices_mtgox_usd = TickerPicker::Ticker.get_prices 'mtgox', 'btc_usd'
    #<TickerPicker::Price:0x007f8f2482e758 @ask=1010.0, @bid=1003.671, @currency="USD", @last=1003.666, @timestamp=1389049160.512882>
    prices_bitstamp_usd = TickerPicker::Ticker.get_prices 'bitstamp', 'btc_usd'
    #<TickerPicker::Price:0x007f8f24855218 @ask=915.74, @bid=915.24, @currency="USD", @last=915.24, @timestamp=1389049155.0>
    
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
    {"btc_usd"=>#<TickerPicker::Price:0x007f8f23b17a38 @ask=1009.945, @bid=1005.0, @currency="USD", @last=1009.995, @timestamp=1389049209.608274>, "btc_eur"=>#<TickerPicker::Price:0x007f8f23af7710 @ask=735.0, @bid=727.0, @currency="EUR", @last=727.0, @timestamp=1389049215.239725>}

Get prices from all avaliable stock-markets

    all_stock_markets = TickerPicker::Ticker.get_all_stock_market_prices
    {"bitstamp"=>{"btc_usd"=>#<TickerPicker::Price:0x007f8f23ace568 @ask=913.44, @bid=912.84, @currency="USD", @last=913.44, @timestamp=1389049226.0>}, "btce"=>{"btc_usd"=>#<TickerPicker::Price:0x007f8f23ab2f70 @ask=916.089, @bid=914.449, @currency="USD", @last=916.089, @timestamp=1389049239.0>, "btc_eur"=>#<TickerPicker::Price:0x007f8f23a98328 @ask=695.89199, @bid=692.02567, @currency="EUR", @last=692.03, @timestamp=1389049241.0>}, "btcturk"=>{"btc_try"=>#<TickerPicker::Price:0x007f8f23a69230 @ask=1909.94, @bid=1880.0, @currency="TRY", @last=1895.99, @timestamp=1389049245.0>}, "mtgox"=>{"btc_usd"=>#<TickerPicker::Price:0x007f8f23a511d0 @ask=1010.0, @bid=1005.005, @currency="USD", @last=1005.0, @timestamp=1389049229.681736>, "btc_eur"=>#<TickerPicker::Price:0x007f8f23a39dc8 @ask=735.0, @bid=727.0, @currency="EUR", @last=727.0, @timestamp=1389049241.310519>}}

To convert results to hash use *to_dh* method like:
    
    all_stock_markets.to_dh
    {"bitstamp"=>{"btc_usd"=>{:ask=>913.44, :bid=>912.84, :currency=>"USD", :last=>913.44, :timestamp=>1389049226.0}}, "btce"=>{"btc_usd"=>{:ask=>916.089, :bid=>914.449, :currency=>"USD", :last=>916.089, :timestamp=>1389049239.0}, "btc_eur"=>{:ask=>695.89199, :bid=>692.02567, :currency=>"EUR", :last=>692.03, :timestamp=>1389049241.0}}, "btcturk"=>{"btc_try"=>{:ask=>1909.94, :bid=>1880.0, :currency=>"TRY", :last=>1895.99, :timestamp=>1389049245.0}}, "mtgox"=>{"btc_usd"=>{:ask=>1010.0, :bid=>1005.005, :currency=>"USD", :last=>1005.0, :timestamp=>1389049229.681736}, "btc_eur"=>{:ask=>735.0, :bid=>727.0, :currency=>"EUR", :last=>727.0, :timestamp=>1389049241.310519}}}

## Configuration (optional & advanced)
Set your stocks.yml file path if you need to modify default

    TickerPicker.configure  do |config|
      config.stock_configuration_file = "#{File.dirname(__FILE__)}/stocks.yml" # your stocks.yml path
    end

Add new stock markets to your stocks.yml

    bitstamp:
      btc_usd:
        url: 'https://www.bitstamp.net/api/ticker/'
        currency: 'USD'
        mappings: 
          ask: "['ask']"
          bid: "['bid']"
          last: "['last']"
          timestamp: "['timestamp']"
          timestamp_representation: 'milliseconds'
    btce:
      btc_usd:
        url: 'https://btc-e.com/api/2/btc_usd/ticker'
        currency: 'USD'
        mappings: 
          ask: "['ticker']['buy']"
          bid: "['ticker']['sell']"
          last: "['ticker']['last']"
          timestamp: "['ticker']['updated']"
          timestamp_representation: 'milliseconds'
      btc_eur:
        url: 'https://btc-e.com/api/2/btc_eur/ticker'
        currency: 'EUR'
        mappings: 
          ask: "['ticker']['buy']"
          bid: "['ticker']['sell']"
          last: "['ticker']['last']"
          timestamp: "['ticker']['updated']"
          timestamp_representation: 'milliseconds'
    btcturk:
      btc_try:
        url: 'https://btcturk.com/api/ticker/'
        currency: 'TRY'
        mappings: 
          ask: "['ask']"
          bid: "['bid']"
          last: "['last']"
          timestamp: "['timestamp']"
          timestamp_representation: 'milliseconds'
    mtgox:
      btc_usd:
        url: 'http://data.mtgox.com/api/2/BTCUSD/money/ticker_fast'
        currency: 'USD'
        mappings: 
          ask: "['data']['sell']['value']"
          bid: "['data']['buy']['value']"
          last: "['data']['last']['value']"
          timestamp: "['data']['now']"
          timestamp_representation: 'microseconds'
      btc_eur:
        url: 'http://data.mtgox.com/api/2/BTCEUR/money/ticker_fast'
        currency: 'EUR'
        mappings: 
          ask: "['data']['sell']['value']"
          bid: "['data']['buy']['value']"
          last: "['data']['last']['value']"
          timestamp: "['data']['now']"
          timestamp_representation: 'microseconds'
    


## Sample Stocks

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
