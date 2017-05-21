require 'spec_helper'

RSpec.describe AnsiEscape::Effects::Base do
  it 'cannot be instantiated' do
    expect { AnsiEscape::Effects::Base.new }.to raise_error(NotImplementedError)
  end
end
