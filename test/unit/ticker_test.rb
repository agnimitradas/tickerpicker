require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))


class TickerTest < Test::Unit::TestCase
  def setup
    TickerPicker.configure  do |config|
      config.stock_configuration_file = "#{File.dirname(__FILE__)}/stocks.yml"
    end
  end

  def test_get_prices
    prices = TickerPicker::Ticker.get_prices('developer', 'btc_xxx')
    assert_equal(
      744.90,
      prices.ask
    )
    assert_equal(
      1388595315.0,
      prices.timestamp
    )
  end

  def test_get_all_stock_prices
    stock_prices = TickerPicker::Ticker.get_all_stock_prices('developer')
    assert_equal(
      744.90,
      stock_prices['btc_xxx'].ask
    )
  end
  
  def test_get_all_stock_market_prices
    stock_market_prices = TickerPicker::Ticker.get_all_stock_market_prices
    assert_equal(
      742.58,
      stock_market_prices['developer']['btc_xxx'].bid
    )
    assert_equal(
      744.94,
      stock_market_prices['tester']['btc_xyz'].ask
    )
    assert_equal(
      1388595315.0,
      stock_market_prices['tester']['btc_xyz'].timestamp
    )
  end
end

