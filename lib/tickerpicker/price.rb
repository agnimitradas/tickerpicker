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
      @currency = price_hash[:currency] || ''
      @last = price_hash[:last] || 0.0
      @timestamp = price_hash[:timestamp].to_f || Time.now.to_f
    end

    class << self
      # Get prices for the market
      #
      # ==== Parameters
      #
      # * +market+ - string
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - TickerPicker::Price instance object
      #
      def get_prices(market)
        instance_mapping gather_info(markets[market]['url']), markets[market]['currency']
      end

      # Abstact method for list of markets in the stock
      #
      def markets
        raise NotImplementedError.new("#{self.class.name}##{__callee__} method is not implemented!")
      end
      
      # Abstact method for mapping foreign data with local instance
      #
      def instance_mapping
        raise NotImplementedError.new("#{self.class.name}##{__callee__} method is not implemented!")
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
    end
  end
end