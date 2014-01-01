require 'open-uri'
require 'json'
require 'hashable'
require 'tickerpicker/version'
require 'tickerpicker/configuration'
require 'tickerpicker/price'
require 'tickerpicker/ticker'
module TickerPicker
  def self.config
    TickerPicker::Configuration.instance
  end

  def self.configure
    yield config
  end

  def self.logger
    config.logger
  end
end
