require 'spec_helper'

RSpec.describe ANSIEscape::Effects::BackgroundColor do
  describe '.new' do
    context 'with color name provided' do
      it 'works with valid color names' do
        [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white].each do |color|
          expect { ANSIEscape::Effects::BackgroundColor.new(color) }.to_not raise_error
        end
      end

      it 'fails with an invalid color name' do
        expect { ANSIEscape::Effects::BackgroundColor.new(:aquamarine) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = ANSIEscape::Effects::BackgroundColor.new(:red)
        expect(effect.color_code).to eq(41)
      end

      it 'sets color_name' do
        effect = ANSIEscape::Effects::BackgroundColor.new(:red)
        expect(effect.color_name).to eq(:red)
      end
    end

    context 'with color code provided' do
      it 'works with valid color codes' do
        expect { ANSIEscape::Effects::BackgroundColor.new(40) }.to_not raise_error
        expect { ANSIEscape::Effects::BackgroundColor.new(47) }.to_not raise_error
      end

      it 'fails with invalid color codes' do
        expect { ANSIEscape::Effects::BackgroundColor.new(39) }.to raise_error(ArgumentError)
        expect { ANSIEscape::Effects::BackgroundColor.new(48) }.to raise_error(ArgumentError)
        expect { ANSIEscape::Effects::BackgroundColor.new(30) }.to raise_error(ArgumentError)
      end

      it 'sets color_code' do
        effect = ANSIEscape::Effects::BackgroundColor.new(42)
        expect(effect.color_code).to eq(42)
      end

      it 'sets color_name' do
        effect = ANSIEscape::Effects::BackgroundColor.new(42)
        expect(effect.color_name).to eq(:green)
      end
    end
  end

  describe '#apply_to' do
    let(:effect) { ANSIEscape::Effects::BackgroundColor.new(:red) }

    it 'applies specified color' do
      result = effect.apply_to('foo bar baz')
      expect(result).to be_an(ANSIEscape::FormattedString)
      expect(result.to_s).to eq("\e[41mfoo bar baz\e[49m")
    end

    it 'works with an ANSIEscape::FormattedString' do
      fs = ANSIEscape::FormattedString.new('foo bar baz')
      result = effect.apply_to(fs)
      expect(result).to be_an(ANSIEscape::FormattedString)
      expect(result.to_s).to eq("\e[41mfoo bar baz\e[49m")
    end
  end

  describe '#==' do
    context 'with the same text color' do
      it 'returns true' do
        e1 = ANSIEscape::Effects::BackgroundColor.new(:magenta)
        e2 = ANSIEscape::Effects::BackgroundColor.new(:magenta)
        expect(e1 == e2).to eq(true)
      end
    end

    context 'with another text color' do
      it 'returns false' do
        e1 = ANSIEscape::Effects::BackgroundColor.new(:magenta)
        e2 = ANSIEscape::Effects::BackgroundColor.new(:yellow)
        expect(e1 == e2).to eq(false)
      end
    end
  end
end
