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
end
