module AnsiEscape
  module Effects
    class Composition < Base
      attr_reader :effects

      def initialize(*effects)
        @effects = effects
      end

      def apply(string)
        effects.inject(string) { |s, effect| effect.apply(s) }
      end
    end
  end
end
