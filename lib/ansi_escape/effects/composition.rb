module ANSIEscape
  module Effects
    class Composition < Base
      attr_reader :effects

      def initialize(*effects)
        @effects = effects
      end

      def apply_to(string)
        fs = FormattedString.new(string)
        effects.each do |effect|
          fs.add_effect(effect, 0..(string.length - 1))
        end
        fs
      end

      # regard two Compositions as equal if they have consist of the same
      # effects in the same order
      def ==(other)
        if !other.is_a?(Composition) || self.effects.length != other.effects.length
          return false
        end

        effects.each_with_index.all? do |effect, i|
          effect == other.effects[i]
        end
      end
    end
  end
end
