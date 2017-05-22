module ANSIEscape
  module Effects
    class Underline < Base
      def start_sequence
        "\e[4m"
      end

      def stop_sequence
        "\e[24m"
      end
    end
  end
end
