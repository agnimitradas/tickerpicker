module TickerPicker
  class Price
    include Hashable

    attr_accessor :ask
    attr_accessor :bid
    attr_accessor :currency
    attr_accessor :last
    attr_accessor :timestamp

    def initialize(price_hash = {})
      @ask = price_hash[:ask] || 0.0
      @bid = price_hash[:bid] || 0.0
      @currency = price_hash[:currency] || 'N/A'
      @last = price_hash[:last] || 0.0
      @timestamp = price_hash[:timestamp] || Time.now.to_f
    end

    class << self
      # Get prices for the market
      #
      # ==== Parameters
      #
      # * +stock_name+ - string
      # * +market_name+ - string
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - TickerPicker::Price instance object
      #
      def fetch(stock_name, market_name)
        stock_market = get_stock_market(stock_name, market_name)
        instance_mapping gather_info(stock_market['url']), stock_market['mappings'], stock_market['currency']
      end

      private
      # Get prices for the market
      #
      # ==== Parameters
      #
      # * +stock_name+ - string
      # * +market_name+ - string
      #
      # === Returns
      #
      # * Hash of markets
      #
      def get_stock_market(stock_name, market_name)
        TickerPicker::Configuration.avaliable_stocks[stock_name][market_name]
      end

      # Get information from stock-market uri and convert it into Hash
      #
      # ==== Parameters
      #
      # * +url+ - Stock market URI
      #
      # === Returns
      #
      # * +Hash+ - Hash of information for given stock-market uri
      #
      def gather_info(url)
        JSON.parse(
          (url =~ URI::regexp ? open(url, 'User-Agent' => user_agent, read_timeout: 2) : open(url)).read
        )
      end

      # nodoc
      def user_agent
        "TickerPicker Bot v#{TickerPicker::VERSION}"
      end

      # nodoc
      def instance_mapping(res_hash, mappings, currency)
        new({
          ask: hash_val_to_f(res_hash, mappings['ask']),
          bid: hash_val_to_f(res_hash, mappings['bid']),
          currency: currency,
          last: hash_val_to_f(res_hash, mappings['last']),
          timestamp: timestamp(
            hash_val_to_f(res_hash, mappings['timestamp']),
            mappings['timestamp_representation']
          )
        })
      end

      # nodoc
      def timestamp(timestamp, timestamp_representation)
        timestamp_representation.eql?('microseconds') ? timestamp / 1000000 : timestamp
      end

      # nodoc
      def hash_val(hash, key)
        eval("hash#{key}")
      end

      # nodoc
      def hash_val_to_f(hash, key)
        ("%f" % hash_val(hash, key)).to_f
      end
    end
  end
end