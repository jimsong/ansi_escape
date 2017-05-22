module ANSIEscape
  module Effects
    # abstract base class
    class Base
      def initialize
        if self.class == Base
          raise NotImplementedError
        end
      end

      def apply(string)
        "#{start_sequence}#{string}#{stop_sequence}"
      end

      def start_sequence
        raise NotImplementedError
      end

      def stop_sequence
        raise NotImplementedError
      end

      # consider two effects equal if their start sequences are the same
      def ==(other)
        start_sequence == other.start_sequence
      end
      alias_method :eql?, :==

      # so we can use effects as hash keys
      def hash
        # two instances of the same Effect class will have the same start_sequence
        # as such, they will have the same hash as well
        start_sequence.hash
      end
    end
  end
end
