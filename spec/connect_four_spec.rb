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

      context "when there is a winner in another row (second to last)" do
        let(:game_horizontal_win){ConnectFour.new([1,3,2,1,2,4,3,3,4,5,5])}
        
        it "returns true" do
          expect(game_horizontal_win).to have_winner
        end
      end

      context "when there is no winner" do
        let(:game_horizontal_win){ConnectFour.new([1,1,4,3,5,7,6,2])}
        
        it "returns false" do
          expect(game_horizontal_win).not_to have_winner
        end
      end
    end
  end
end