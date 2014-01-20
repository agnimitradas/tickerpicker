require 'singleton'
require 'logger'
require 'yaml'

module TickerPicker
  class Configuration
    include Singleton
    attr_accessor :logger
    attr_accessor :stock_configuration_file


    class << self
      def default_logger
        logger = Logger.new(STDOUT)
        logger.progname = 'tickerpicker'
        logger
      end

      def defaults
        @@defaults
      end

      def stocks
        @stocks ||= YAML.load_file(TickerPicker.config.stock_configuration_file)
      end
    end

    def initialize
      @@defaults.each_pair{ |k,v| self.send("#{k}=",v) }
    end

    @@defaults = {
      logger: default_logger,
      stock_configuration_file: "#{File.dirname(__FILE__)}/stocks.yml"
    }

  end
end