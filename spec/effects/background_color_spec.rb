require 'spec_helper'

RSpec.describe AnsiEscape::Effects::BackgroundColor do
  describe '.new' do
    context 'with color name provided' do
      it 'works with valid color names' do
        [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
          expect { AnsiEscape::Effects::BackgroundColor.new(color) }.to_not raise_error
        end
      end

      it 'fails with an invalid color name' do
        expect { AnsiEscape::Effects::BackgroundColor.new(:aquamarine) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = AnsiEscape::Effects::BackgroundColor.new(:red)
        expect(effect.color_code).to eq(41)
      end
    end

    context 'with color code provided' do
      it 'works with valid color codes' do
        expect { AnsiEscape::Effects::BackgroundColor.new(40) }.to_not raise_error
        expect { AnsiEscape::Effects::BackgroundColor.new(47) }.to_not raise_error
      end

      it 'fails with invalid color codes' do
        expect { AnsiEscape::Effects::BackgroundColor.new(39) }.to raise_error(ArgumentError)
        expect { AnsiEscape::Effects::BackgroundColor.new(48) }.to raise_error(ArgumentError)
        expect { AnsiEscape::Effects::BackgroundColor.new(30) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = AnsiEscape::Effects::BackgroundColor.new(42)
        expect(effect.color_code).to eq(42)
      end
    end
  end

  describe '#apply' do
    it 'applies specified color' do
      effect = AnsiEscape::Effects::BackgroundColor.new(:red)
      result = effect.apply('foo bar baz')
      expect(result).to eq("\e[41mfoo bar baz\e[49m")
    end
  end
end
