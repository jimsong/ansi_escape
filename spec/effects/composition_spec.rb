require 'spec_helper'

RSpec.describe ANSIEscape::Effects::Composition do
  let(:underline) { ANSIEscape::Effects::Underline.new }
  let(:red_text) { ANSIEscape::Effects::TextColor.new(:red) }
  let(:green_background) { ANSIEscape::Effects::BackgroundColor.new(:green) }

  describe '.new' do
    it 'works with no arguments' do
      expect { ANSIEscape::Effects::Composition.new }.to_not raise_error
    end

    it 'works with with a list of effects' do
      expect do
        ANSIEscape::Effects::Composition.new(
          underline,
          red_text,
          green_background
        )
      end.to_not raise_error
    end
  end

  describe '#apply_to' do
    context 'with no effects provided' do
      it 'does nothing' do
        effect = ANSIEscape::Effects::Composition.new
        result = effect.apply_to('foo bar baz')
        expect(result).to eq('foo bar baz')
      end
    end

    context 'with a list of effects provided' do
      it 'composes the effects' do
        effect = ANSIEscape::Effects::Composition.new(
          underline,
          red_text,
          green_background
        )
        result = effect.apply_to('foo bar baz')
        expect(result).to eq("\e[42m\e[31m\e[4mfoo bar baz\e[24m\e[39m\e[49m")
      end
    end
  end

  describe '#==' do
    context 'with an instance of another effect' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::Composition.new
        e2 = ANSIEscape::Effects::TextColor.new(:red)
        expect(e1 == e2).to eq(false)
      end
    end

    context 'with another instance composed of different effects' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::Composition.new(underline, red_text, green_background)
        e2 = ANSIEscape::Effects::Composition.new(underline, red_text)
        expect(e1 == e2).to eq(false)
      end
    end

    context 'with another instance composed of same effects in different order' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::Composition.new(underline, red_text, green_background)
        e2 = ANSIEscape::Effects::Composition.new(underline, green_background, red_text)
        expect(e1 == e2).to eq(false)
      end
    end

    context 'with another instance composed of same effects in same order' do
      it 'returns true' do
        e1 = ANSIEscape::Effects::Composition.new(underline, red_text, green_background)
        e2 = ANSIEscape::Effects::Composition.new(underline, red_text, green_background)
        expect(e1 == e2).to eq(true)
      end
    end
  end
end
