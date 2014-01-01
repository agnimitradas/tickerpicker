module TickerPicker
  module Factory
    class Tester < TickerPicker::Price
      class << self


        # Get prices for the market
        #
        # === Returns
        #
        # * Hash of markets
        #
        def markets
          TickerPicker::Configuration.avaliable_stocks['tester']
        end

        private

        # nodoc
        def instance_mapping(res_hash, currency)
          new({
            ask: ("%f" % res_hash['ask']).to_f,
            bid: ("%f" % res_hash['bid']).to_f,
            currency: currency,
            last: ("%f" % res_hash['last']).to_f,
            timestamp: res_hash['timestamp']
          })
        end
      end
    end
  end
end