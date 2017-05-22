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
    end
  end
end
