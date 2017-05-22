module ANSIEscape
  class FormattedString
    def initialize(raw_text)
      @raw_text = raw_text

      # maps each effect to an array of the start/stop ranges of that effect
      @effect_ranges = {}
    end

    def raw_text
      @raw_text.dup # so no one can mutate the text and cause inconsistencies!
    end

    def add_effect(effect, start, stop)
      # TODO: deal with overlaps and conflicting effects! (e.g. new green text range overlapping with an existing red text range)
      # TODO: range validation
      # TODO: handle Compositions
      @effect_ranges[effect] ||= []
      @effect_ranges[effect] << (start..stop)
    end

    def remove_effect(effect, start, stop)
      # TODO: implement!
    end

    # returns all the active effects at a given position in the string
    def effects_at(position)
      result = []
      @effect_ranges.each_pair do |effect, ranges|
        if ranges.any? { |range| range.include?(position) }
          result << effect
        end
      end
      result
    end

    def ranges_for(effect)
      @effect_ranges[effect]
    end

    def to_s
      start_sequences = {}
      stop_sequences = {}

      @effect_ranges.each_pair do |effect, ranges|
        ranges.each do |range|
          start_sequences[range.first] ||= []
          start_sequences[range.first] << effect.start_sequence
          stop_sequences[range.last] ||= []
          stop_sequences[range.last] << effect.stop_sequence
        end
      end

      positions = (start_sequences.keys + stop_sequences.keys).uniq.sort
      cursor_position = 0
      result = ''

      positions.each do |position|
        if start_sequences[position]
          result += raw_text[cursor_position..(position - 1)]
          start_sequences[position].each do |sequence|
            result += sequence
          end
          cursor_position = position
        end
        result += raw_text[cursor_position..position]
        if stop_sequences[position]
          stop_sequences[position].each do |sequence|
            result += sequence
          end
        end
        cursor_position = position + 1
      end

      result += raw_text[cursor_position, raw_text.length]
      result
    end
  end
end
