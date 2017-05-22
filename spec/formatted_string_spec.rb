require 'spec_helper'

RSpec.describe ANSIEscape::FormattedString do
  describe '#new' do
    it 'sets raw_text' do
      fs = ANSIEscape::FormattedString.new('foo bar baz')
      expect(fs.raw_text).to eq('foo bar baz')
    end
  end

  describe '#raw_text' do
    it 'cannot be used to mutate the string' do
      fs = ANSIEscape::FormattedString.new('foo bar baz')
      copy = fs.raw_text
      copy[0] = 'b' # should not mutate internal string!
      expect(fs.raw_text).to eq('foo bar baz')
    end
  end

  describe '#effects_at' do
    let(:underline) { ANSIEscape::Effects::Underline.new }
    let(:red_text) { ANSIEscape::Effects::TextColor.new(:red) }
    let(:green_background) { ANSIEscape::Effects::BackgroundColor.new(:green) }
    let(:formatted_string) { ANSIEscape::FormattedString.new('foo bar baz') }

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
