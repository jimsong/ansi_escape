module ANSIEscape
  module Effects
    class TextColor < Base
      COLOR_CODES = {
        black: 30,
        red: 31,
        green: 32,
        yellow: 33,
        blue: 34,
        magenta: 35,
        cyan: 36,
        white: 37
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
        "\e[39m"
      end
    end
  end
end
