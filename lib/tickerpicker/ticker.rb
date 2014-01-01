module TickerPicker
  class Ticker
    @@factories = {}

    class << self
      # Get factories hash
      #
      # === Returns
      #
      # * +factories+ - Hash
      #
      def factories
        @@factories
      end

      # Register a ticker factory
      #
      # ==== Parameters
      #
      # * +stock+ - Factory object name
      # * +file_path+ - Optional load path for stock handler factory for new dev purposes
      #
      # === Returns
      #
      # * +true+ - Boolean
      #
      def register(stock, file_path = nil)
        require (file_path || "#{File.dirname(__FILE__)}/factory/#{stock}")
        factories[stock] = eval("TickerPicker::Factory::#{stock.capitalize}.markets")
        true
      end

      # Register multiple ticker factories
      #
      # ==== Parameters
      #
      # * +stocks+ - Factory object name list
      #
      # === Returns
      #
      # * +true+ - Boolean
      #
      def register_list(stocks)
        stocks.each { |stock| register(stock) }
        true
      end

      # Get prices for market in stock
      #
      # ==== Parameters
      #
      # * +stock+ - String which must be a valid stock name
      # * +market+ - String which should include valid market name
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - Extended version of TickerPicker::Price with factory key
      #
      def get_prices(stock, market)
        return stock_market_does_not_exists unless (factories[stock] || {}).has_key?(market)
        get_price_without_check(stock, market)
      end

      # Get all market prices in a stock
      #
      # ==== Parameters
      #
      # * +stock+ - String which must be a valid stock name
      #
      # === Returns
      #
      # * +Hash+ - Hash of TickerPicker::Price
      #
      def get_all_stock_prices(stock)
        return stock_does_not_exists unless factories.has_key?(stock)
        get_all_stock_prices_without_check(stock)
      end

      # Get all market prices in avaliable stocks
      #
      # ==== Parameters
      #
      # * +stock+ - String which must be a valid stock name
      #
      # === Returns
      #
      # * +Hash+ - Hash of TickerPicker::Price
      #
      def get_all_stock_market_prices
        stock_market_prices = {}
        factories.each do |stock_key, _|
          stock_market_prices.merge!({ stock_key => get_all_stock_prices_without_check(stock_key) })
        end
        stock_market_prices
      end

      private
      # nodoc
      def get_price_without_check(stock, market)
        eval("TickerPicker::Factory::#{stock.capitalize}.get_prices(market)")
      end

      # nodoc
      def get_all_stock_prices_without_check(stock)
        stock_prices = {}
        factories[stock].each do |key, _|
          stock_prices[key] = get_price_without_check(stock, key)
        end
        stock_prices
      end

      # nodoc
      def stock_does_not_exists
        raise StandardError, 'Stock does not exists!'
      end

      # nodoc
      def stock_market_does_not_exists
        raise StandardError, 'Stock-market does not exists!'
      end
    end
  end
end
