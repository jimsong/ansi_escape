require 'spec_helper'

RSpec.describe ANSIEscape::FormattedString do
  let(:underline) { ANSIEscape::Effects::Underline.new }
  let(:red_text) { ANSIEscape::Effects::TextColor.new(:red) }
  let(:green_background) { ANSIEscape::Effects::BackgroundColor.new(:green) }
  let(:formatted_string) { ANSIEscape::FormattedString.new('foo bar baz') }

  describe '#new' do
    it 'sets raw_text' do
      expect(formatted_string.raw_text).to eq('foo bar baz')
    end
  end

  describe '#raw_text' do
    it 'cannot be used to mutate the string' do
      copy_of_text = formatted_string.raw_text
      copy_of_text[0] = 'b' # should not mutate internal string!
      expect(formatted_string.raw_text).to eq('foo bar baz')
    end
  end

  describe '#add_effect' do
    it 'adds the specified effect to the provided range of indexes' do
      formatted_string.add_effect(red_text, 4..6)
      expect(formatted_string.effects_at(4)).to eq([red_text])
      expect(formatted_string.effects_at(5)).to eq([red_text])
      expect(formatted_string.effects_at(6)).to eq([red_text])
    end

    it 'does not add the specified effect outside the provided range of indexes' do
      formatted_string.add_effect(red_text, 4..6)
      expect(formatted_string.effects_at(3)).to eq([])
      expect(formatted_string.effects_at(7)).to eq([])
    end

    it 'replaces effects of the same type' do
      green_text = ANSIEscape::Effects::TextColor.new(:green)
      blue_text = ANSIEscape::Effects::TextColor.new(:blue)
      formatted_string.add_effect(red_text, 0..10)
      formatted_string.add_effect(green_text, 4..4)
      formatted_string.add_effect(blue_text, 5..5)
      expect(formatted_string.effects_at(3)).to eq([red_text])
      expect(formatted_string.effects_at(4)).to eq([green_text])
      expect(formatted_string.effects_at(5)).to eq([blue_text])
      expect(formatted_string.effects_at(6)).to eq([red_text])
    end
  end

  describe '#effects_at' do
    before do
      formatted_string.add_effect(underline, 4..6)
      formatted_string.add_effect(red_text, 4..6)
      formatted_string.add_effect(green_background, 4..6)
    end

    it 'returns an array of effects active at the given index' do
      active_effects = formatted_string.effects_at(5)
      expect(active_effects).to be_an(Array)
      expect(active_effects.size).to eq(3)
      expect(active_effects).to include(underline, red_text, green_background)
    end

    it 'returns an empty array with no effects at the given index' do
      active_effects = formatted_string.effects_at(0)
      expect(active_effects).to eq([])
    end
  end
end
