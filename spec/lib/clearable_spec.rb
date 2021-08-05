require 'spec_helper'

RSpec.describe Clearable do
  Handler = Class.new
  Handler.extend(Clearable)

  describe '#truncate_spaces' do
    it 'should remove repeating spaces' do
      str = '  some  dat a'
      result = Handler.truncate_spaces(str)
      expect(result).to eq(' some dat a')
    end

    it 'should not remove any spaces' do
      str = 'some dat a '
      result = Handler.truncate_spaces(str)
      expect(result).to eq('some dat a ')
    end
  end

  describe '#clear_symbols' do
    it 'should remove all \n and \r symbols' do
      str = "\n\r some \rdata \r\r"
      result = Handler.clear_symbols(str)
      expect(result).to eq(' some data ')
    end
  end

  describe '#clear_multiple_spaces' do
    it 'should remove all 2 and more spaces' do
      str = "  some dat  a "
      result = Handler.clear_multiple_spaces(str)
      expect(result).to eq('some data ')
    end
  end


end
