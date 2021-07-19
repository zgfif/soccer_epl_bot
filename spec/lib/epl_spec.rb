require 'spec_helper'

RSpec.describe Epl do
  it 'should return recent english results' do
    matches = Epl.new.recent
    expect(matches.first).to eq('38-й тур. 23.05.2021')
    expect(matches.last).to eq('18:00 Вест Хэм 3:0 Саутгемптон')
  end
end
