require 'spec_helper'

RSpec.describe Champions do
  it 'should return upcoming matches' do
    matches = Champions.new.upcoming
    expect(matches.last).to eq('20:30 Шахтер -:- Генк')
    expect(matches.first).to eq('Квалификация. 3 раунд')
  end
end
