module ANSIEscape
  module Effects
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
    end
  end
end
