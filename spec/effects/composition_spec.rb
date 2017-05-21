require 'spec_helper'

RSpec.describe AnsiEscape::Effects::Composition do
  let(:underline) { AnsiEscape::Effects::Underline.new }
  let(:red_text) { AnsiEscape::Effects::TextColor.new(:red) }
  let(:green_background) { AnsiEscape::Effects::BackgroundColor.new(:green) }

  describe '.new' do
    it 'works with no arguments' do
      expect { AnsiEscape::Effects::Composition.new }.to_not raise_error
    end

    it 'works with with a list of effects' do
      expect do
        AnsiEscape::Effects::Composition.new(
          underline,
          red_text,
          green_background
        )
      end.to_not raise_error
    end
  end

  describe '#apply' do
    context 'with no effects provided' do
      it 'does nothing' do
        effect = AnsiEscape::Effects::Composition.new
        result = effect.apply('foo bar baz')
        expect(result).to eq('foo bar baz')
      end
    end

    context 'with a list of effects provided' do
      it 'composes the effects' do
        effect = AnsiEscape::Effects::Composition.new(
          underline,
          red_text,
          green_background
        )
        result = effect.apply('foo bar baz')
        expect(result).to eq("\e[42m\e[31m\e[4mfoo bar baz\e[24m\e[39m\e[49m")
      end
    end
  end
end
