module TickerPicker
  class Ticker
    class << self
      # Get prices for market in stock
      #
      # ==== Parameters
      #
      # * +stock_name+ - String which must be a valid stock name
      # * +market_name+ - String which should include valid market name
      #
      # === Returns
      #
      # * +TickerPicker::Price+ - TickerPicker::Price instance
      #
      def get_prices(stock_name, market_name)
        (stocks[stock_name] || {}).has_key?(market_name) ? get_price_without_check(stocks[stock_name][market_name]) : stock_market_does_not_exists
      end

      # Get all market prices in a stock
      #
      # ==== Parameters
      #
      # * +stock_name+ - String which must be a valid stock name
      #
      # === Returns
      #
      # * +Hash+ - Hash of TickerPicker::Price
      #
      def get_all_stock_prices(stock_name)
        stocks.has_key?(stock_name) ? get_all_stock_prices_without_check(stocks[stock_name]) : stock_does_not_exists
      end

      # Get all market prices in avaliable stocks
      #
      # === Returns
      #
      # * +Hash+ - Hash of TickerPicker::Price
      #
      def get_all_stock_market_prices
        stock_market_prices = {}
        stocks.each do |stock_key, _|
          stock_market_prices.merge!({ stock_key => get_all_stock_prices_without_check(stocks[stock_key]) })
        end
        stock_market_prices
      end

      private
      # nodoc
      # @return [Hash]
      def stocks
        @stocks ||= TickerPicker::Configuration.stocks
      end

      # nodoc
      def get_price_without_check(stock_market)
        TickerPicker::Price.fetch(stock_market)
      end

      # nodoc
      def get_all_stock_prices_without_check(stock)
        stock_prices = {}
        stock.each do |key, _|
          stock_prices[key] = get_price_without_check(stock[key])
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
