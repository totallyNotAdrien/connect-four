require "../lib/connect_four.rb"

describe ConnectFour do
  describe "#has_winner?" do
    context "when there is a winner horizontally" do
      context "when there is a winner on the bottom row" do
        let(:game_horizontal_win){ConnectFour.new([1,1,2,2,3,3,4])}
        
        it "returns true" do
          expect(game_horizontal_win).to have_winner
        end
      end

      context "when there is a winner another row" do

      end
    end
  end
end