require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))


class TickerTest < Test::Unit::TestCase
  def setup
    TickerPicker.configure  do |config|
      config.stock_configuration_file = "#{File.dirname(__FILE__)}/stocks.yml"
    end
  end

  def test_register
    register_developer
    assert_equal(
      true,
      TickerPicker::Ticker.factories.has_key?('developer')
    )
  end

  def test_register_list
    assert_equal(
      true,
      true
    )
  end

  def test_get_prices
    register_developer
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
    register_all
    stock_prices = TickerPicker::Ticker.get_all_stock_prices('developer')
    assert_equal(
      744.90,
      stock_prices['btc_xxx'].ask
    )
  end

  def test_get_all_stock_market_prices
    register_all
    stock_market_prices = TickerPicker::Ticker.get_all_stock_market_prices
    assert_equal(
      742.58,
      stock_market_prices['developer']['btc_xxx'].bid
    )
    assert_equal(
      744.94,
      stock_market_prices['tester']['btc_xyz'].ask
    )
  end

  private
  def register_developer
    TickerPicker::Ticker.register('developer', File.expand_path(File.join(File.dirname(__FILE__), 'factory', 'developer')))
    TickerPicker::Ticker.factories['developer']['btc_xxx']['url'] = "#{File.dirname(__FILE__)}/json/developer.json"
  end

  def register_tester
    TickerPicker::Ticker.register('tester', File.expand_path(File.join(File.dirname(__FILE__), 'factory', 'tester')))
    TickerPicker::Ticker.factories['tester']['btc_xyz']['url'] = "#{File.dirname(__FILE__)}/json/tester.json"
  end

  def register_all
    register_developer
    register_tester
  end
end

