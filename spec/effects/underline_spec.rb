require 'spec_helper'

RSpec.describe ANSIEscape::Effects::Underline do
  describe '#apply' do
    it 'applies underline' do
      effect = ANSIEscape::Effects::Underline.new
      result = effect.apply('foo bar baz')
      expect(result).to eq("\e[4mfoo bar baz\e[24m")
    end
  end
end
