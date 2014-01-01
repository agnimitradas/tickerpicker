module TickerPicker
  module Factory
    class Mtgox < TickerPicker::Price
      class << self
        # Get prices for the market
        #
        # === Returns
        #
        # * Hash of markets
        #
        def markets
          TickerPicker::Configuration.avaliable_stocks['mtgox']
        end

        private

        # nodoc
        def instance_mapping(res_hash, currency)
          new({
            ask: ("%f" % res_hash['data']['sell']['value']).to_f,
            bid: ("%f" % res_hash['data']['buy']['value']).to_f,
            currency: currency,
            last: ("%f" % res_hash['data']['last']['value']).to_f,
            timestamp: res_hash['data']['now'].to_f / 1000000
          })
        end
      end
    end
  end
end