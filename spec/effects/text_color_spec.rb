require 'spec_helper'

RSpec.describe ANSIEscape::Effects::TextColor do
  describe '.new' do
    context 'with color name provided' do
      it 'works with valid color names' do
        [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
          expect { ANSIEscape::Effects::TextColor.new(color) }.to_not raise_error
        end
      end

      it 'fails with an invalid color name' do
        expect { ANSIEscape::Effects::TextColor.new(:aquamarine) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = ANSIEscape::Effects::TextColor.new(:red)
        expect(effect.color_code).to eq(31)
      end

      it 'sets color_name' do
        effect = ANSIEscape::Effects::TextColor.new(:red)
        expect(effect.color_name).to eq(:red)
      end
    end

    context 'with color code provided' do
      it 'works with valid color codes' do
        expect { ANSIEscape::Effects::TextColor.new(30) }.to_not raise_error
        expect { ANSIEscape::Effects::TextColor.new(37) }.to_not raise_error
      end

      it 'fails with invalid color codes' do
        expect { ANSIEscape::Effects::TextColor.new(29) }.to raise_error(ArgumentError)
        expect { ANSIEscape::Effects::TextColor.new(38) }.to raise_error(ArgumentError)
        expect { ANSIEscape::Effects::TextColor.new(40) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = ANSIEscape::Effects::TextColor.new(32)
        expect(effect.color_code).to eq(32)
      end

      it 'sets color_name' do
        effect = ANSIEscape::Effects::TextColor.new(32)
        expect(effect.color_name).to eq(:green)
      end
    end
  end

  describe '#apply_to' do
    it 'applies specified color' do
      effect = ANSIEscape::Effects::TextColor.new(:red)
      result = effect.apply_to('foo bar baz')
      expect(result).to be_an(ANSIEscape::FormattedString)
      expect(result.to_s).to eq("\e[31mfoo bar baz\e[39m")
    end
  end

  describe '#==' do
    context 'with the same text color' do
      it 'returns true' do
        e1 = ANSIEscape::Effects::TextColor.new(:magenta)
        e2 = ANSIEscape::Effects::TextColor.new(:magenta)
        expect(e1 == e2).to eq(true)
      end
    end

    context 'with another text color' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::TextColor.new(:magenta)
        e2 = ANSIEscape::Effects::TextColor.new(:yellow)
        expect(e1 == e2).to eq(false)
      end
    end
  end
end
