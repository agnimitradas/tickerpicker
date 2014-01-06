module TickerPicker
  class Ticker
    class << self
      # Get prices for market in stock
      #
      # ==== Parameters
      #
      # * +stock+ - String which must be a valid stock name
      # * +market+ - String which should include valid market name
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - TickerPicker::Price instance
      #
      def get_prices(stock, market)
        return stock_market_does_not_exists unless (stocks[stock] || {}).has_key?(market)
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
        return stock_does_not_exists unless stocks.has_key?(stock)
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
        stocks.each do |stock_key, _|
          stock_market_prices.merge!({ stock_key => get_all_stock_prices_without_check(stock_key) })
        end
        stock_market_prices
      end

      private
      # nodoc
      def stocks
        TickerPicker::Configuration.avaliable_stocks
      end

      # nodoc
      def get_price_without_check(stock, market)
        TickerPicker::Price.fetch(stock, market)
      end

      # nodoc
      def get_all_stock_prices_without_check(stock)
        stock_prices = {}
        stocks[stock].each do |key, _|
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
