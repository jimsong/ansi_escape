module ANSIEscape
  class FormattedString
    def initialize(raw_text)
      @raw_text = raw_text

      # each array element corresponds to the same location in the raw_text and
      # contains either nil or an array of effects on that character
      @effects_map = []
    end

    def raw_text
      @raw_text.dup # so no one can mutate the text and cause inconsistencies!
    end

    def add_effect(effect, range)
      # TODO: range validation
      range.each do |i|
        @effects_map[i] ||= Set.new

        # remove existing effects of the same class
        # as an example, green text color will overwrite existing red text color
        @effects_map[i].reject! { |existing_effect| existing_effect.class == effect.class }

        @effects_map[i].add(effect)
      end
    end

    def remove_effect(effect, range)
      # TODO: range validation
      range.each do |i|
        @effects_map[i] ||= Set.new
        @effects_map[i].delete(effect)
      end
    end

    # returns all the active effects at a given index in the string
    def effects_at(index)
      effects = @effects_map[index] || []
      effects.to_a
    end

    def to_s
      # build the output string by iterating through each of the characters in
      # the raw_text, applying effects while keeping track of which effects are
      # active and appending start and stop sequences accordingly
      active_effects = Set.new
      result = ''

      (0..(raw_text.length - 1)).each do |i|
        expected_effects = @effects_map[i] || Set.new
        effects_to_start = expected_effects - active_effects
        effects_to_stop = active_effects - expected_effects

        # append end sequence for effects that should no longer be active
        effects_to_stop.each do |effect|
          result += effect.stop_sequence
          active_effects.delete(effect)
        end

        # append start sequence for new effects that are not yet active
        effects_to_start.each do |effect|
          result += effect.start_sequence
          active_effects.add(effect)
        end

        # append the character itself!
        result += raw_text[i]
      end

      # any remaining active effects need to be stopped
      active_effects.each do |effect|
        result += effect.stop_sequence
      end

      result
    end

    def print
      puts to_s
    end
  end
end
