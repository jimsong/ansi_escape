require 'spec_helper'

RSpec.describe ANSIEscape::Effects::Base do
  it 'cannot be instantiated' do
    expect { ANSIEscape::Effects::Base.new }.to raise_error(NotImplementedError)
  end
end
