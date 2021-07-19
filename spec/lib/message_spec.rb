require 'spec_helper'

RSpec.describe Message do
  it 'should return two rows string' do
    array  = %w{ Row1 Row2 }
    string = Message.build(array)
    expect(string).to eq("Row1\nRow2")
  end

  it 'should return one row string' do
    array  = %w{ Row1 }
    string = Message.build(array)
    expect(string).to eq('Row1')
  end
end
