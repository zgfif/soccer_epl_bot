require 'spec_helper'

RSpec.describe ChampionsLeague do
  it 'should return upcoming matches' do
    matches = ChampionsLeague.new.upcoming
    expect(matches.last).to eq('20:30 Шахтер -:- Генк')
    expect(matches.first).to eq('Квалификация. 3 раунд')
  end
end
