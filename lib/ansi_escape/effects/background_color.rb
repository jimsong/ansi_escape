module ANSIEscape
  module Effects
    class BackgroundColor < Base
      COLOR_CODES = {
        black: 40,
        red: 41,
        green: 42,
        yellow: 43,
        blue: 44,
        magenta: 45,
        cyan: 46,
        white: 47
      }.freeze
      COLOR_NAMES = COLOR_CODES.invert.freeze

      attr_reader :color_code

      def initialize(color)
        if COLOR_CODES[color]
          @color_code = COLOR_CODES[color]
        elsif COLOR_NAMES[color]
          @color_code = color
        else
          raise ArgumentError, 'Invalid color name or code'
        end
      end

      def color_name
        COLOR_NAMES[color_code]
      end

      def start_sequence
        "\e[#{@color_code}m"
      end

      def stop_sequence
        "\e[49m"
      end
    end
  end
end
