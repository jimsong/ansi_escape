require 'spec_helper'

RSpec.describe AnsiEscape::Effects::TextColor do
  describe '.new' do
    context 'with color name provided' do
      it 'works with valid color names' do
        [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
          expect { AnsiEscape::Effects::TextColor.new(color) }.to_not raise_error
        end
      end

      it 'fails with an invalid color name' do
        expect { AnsiEscape::Effects::TextColor.new(:aquamarine) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = AnsiEscape::Effects::TextColor.new(:red)
        expect(effect.color_code).to eq(31)
      end
    end

    context 'with color code provided' do
      it 'works with valid color codes' do
        expect { AnsiEscape::Effects::TextColor.new(30) }.to_not raise_error
        expect { AnsiEscape::Effects::TextColor.new(37) }.to_not raise_error
      end

      it 'fails with invalid color codes' do
        expect { AnsiEscape::Effects::TextColor.new(29) }.to raise_error(ArgumentError)
        expect { AnsiEscape::Effects::TextColor.new(38) }.to raise_error(ArgumentError)
        expect { AnsiEscape::Effects::TextColor.new(40) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = AnsiEscape::Effects::TextColor.new(32)
        expect(effect.color_code).to eq(32)
      end
    end
  end

  describe '#apply' do
    it 'applies specified color' do
      effect = AnsiEscape::Effects::TextColor.new(:red)
      result = effect.apply('foo bar baz')
      expect(result).to eq("\e[31mfoo bar baz\e[39m")
    end
  end
end
