require 'spec_helper'

RSpec.describe ANSIEscape::Effects::Underline do
  describe '#apply_to' do
    let(:effect) { ANSIEscape::Effects::Underline.new }

    it 'applies underline' do
      result = effect.apply_to('foo bar baz')
      expect(result).to be_an(ANSIEscape::FormattedString)
      expect(result.to_s).to eq("\e[4mfoo bar baz\e[24m")
    end

    it 'works with an ANSIEscape::FormattedString' do
      fs = ANSIEscape::FormattedString.new('foo bar baz')
      result = effect.apply_to(fs)
      expect(result).to be_an(ANSIEscape::FormattedString)
      expect(result.to_s).to eq("\e[4mfoo bar baz\e[24m")
    end
  end

  describe '#==' do
    context 'with another instance of ANSIEscape::Effects::Underline' do
      it 'returns true' do
        e1 = ANSIEscape::Effects::Underline.new
        e2 = ANSIEscape::Effects::Underline.new
        expect(e1 == e2).to eq(true)
      end
    end

    context 'with an instance of another effect' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::Underline.new
        e2 = ANSIEscape::Effects::TextColor.new(:red)
        expect(e1 == e2).to eq(false)
      end
    end
  end
end
