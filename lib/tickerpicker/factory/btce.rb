module TickerPicker
  module Factory
    class Btce < TickerPicker::Price
      class << self
        # Get prices for the market
        #
        # === Returns
        #
        # * Hash of markets
        #
        def markets
          TickerPicker::Configuration.avaliable_stocks['btce']
        end

        private

        # nodoc
        def instance_mapping(res_hash, currency)
          new({
            ask: ("%f" % res_hash['ticker']['sell']).to_f,
            bid: ("%f" % res_hash['ticker']['buy']).to_f,
            currency: currency,
            last: ("%f" % res_hash['ticker']['last']).to_f,
            timestamp: res_hash['ticker']['updated']
          })
        end
      end
    end
  end
end