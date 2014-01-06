module TickerPicker
  class Price
    include Hashable

    attr_accessor :ask
    attr_accessor :bid
    attr_accessor :currency
    attr_accessor :last
    attr_accessor :timestamp

    def initialize(price_hash = {})
      @ask = price_hash[:ask].to_f || 0.0
      @bid = price_hash[:bid].to_f || 0.0
      @currency = price_hash[:currency] || ''
      @last = price_hash[:last].to_f || 0.0
      @timestamp = price_hash[:timestamp].to_f || Time.now.to_f
    end

    class << self
      # Get prices for the market
      #
      # ==== Parameters
      #
      # * +stock+ - string
      # * +market+ - string
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - TickerPicker::Price instance object
      #
      def fetch(stock, market)
        instance_mapping gather_info(markets(stock)[market]['url']), markets(stock)[market]
      end

      private
      # Get prices for the market
      #
      # ==== Parameters
      #
      # * +stock+ - string
      #
      # === Returns
      #
      # * Hash of markets
      #
      def markets(stock)
        TickerPicker::Configuration.avaliable_stocks[stock]
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
        response = url =~ URI::regexp ? open(url, 'User-Agent' => user_agent, read_timeout: 2).read : open(url).read
        JSON.parse(response)
      end

      # nodoc
      def user_agent
        "TickerPicker Bot v#{TickerPicker::VERSION}"
      end

      # nodoc
      def instance_mapping(res_hash, stock_market)
        timestamp = eval("res_hash#{stock_market['mappings']['timestamp']}").to_f
        timestamp /= 1000000 if stock_market['mappings']['timestamp_representation'].eql?('microseconds')
        new({
          ask: ("%f" % eval("res_hash#{stock_market['mappings']['ask']}")),
          bid: ("%f" % eval("res_hash#{stock_market['mappings']['bid']}")),
          currency: stock_market['currency'],
          last: ("%f" % eval("res_hash#{stock_market['mappings']['last']}")),
          timestamp: timestamp 
        })
      end
    end
  end
end