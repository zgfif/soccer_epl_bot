require_relative '../last_result'

require 'rspec/its'

RSpec.describe LastResult do

  describe '#page' do
    context do
      before { subject.instance_variable_set :@page, :page }

      its(:page) { should eq :page }
    end

    context do
      before { expect(Nokogiri::HTML).to receive(:parse).with(any_args).and_return(:page) }

      its(:page) { should eq :page }
    end
  end

  describe '#game_feed' do
    let(:page) { double }

    before { expect(subject).to receive(:page).and_return(page) }

    before { expect(page).to receive(:at_css).with('article.game-feed').and_return(:game_feed)}

    its(:game_feed) { should eq :game_feed }
  end

  describe '#perform' do
    let(:array_of_score) { double }

    before { expect(subject).to receive(:array_of_score).and_return(array_of_score) }

    before { expect(array_of_score).to receive(:join).with("\n").and_return(:perform) }

    its(:perform) { should eq :perform }
  end
end
