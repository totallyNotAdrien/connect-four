require "../lib/connect_four.rb"

describe ConnectFour do
  describe "#has_winner?" do
    context "when there is a winner horizontally" do
      context "when there is a winner on the bottom row" do
        let(:game_horizontal_win){described_class.new([1,1,2,2,3,3,4])}
        
        it "returns true" do
          expect(game_horizontal_win).to have_winner
        end
      end

      context "when there is a winner in another row (second to last)" do
        let(:game_horizontal_win){described_class.new([1,3,2,1,2,4,3,3,4,5,5])}
        
        it "returns true" do
          expect(game_horizontal_win).to have_winner
        end
      end
    end

    context "when there is a winner vertically" do
      context "when there is a winner on the leftmost column" do
        let(:game_vertical_win){described_class.new([1,2,1,2,1,2,1])}
        
        it "returns true" do
          expect(game_vertical_win).to have_winner
        end
      end

      context "when there is a winner in another column (fourth)" do
        let(:game_vertical_win){described_class.new([1,4,5,4,5,4,5,4])}
        
        it "returns true" do
          expect(game_vertical_win).to have_winner
        end
      end
    end

    context "when there is a winner diagonally" do
      context "when there is a winner from BL to TR (up)" do
        context "if the winning sequence starts at an edge" do
          let(:game_diag_up){described_class.new([1,2,2,1,3,3,3,4,4,4,4])}
          it "returns true" do
            expect(game_diag_up).to have_winner
          end
        end

        context "if the winning sequence does not start at an edge" do
          let(:game_diag_up){described_class.new([2,3,4,5,2,3,3,6,4,4,4,5,5,5,5])}
          it "returns true" do
            expect(game_diag_up).to have_winner
          end
        end
      end

      context "when there is a winner from TL to BR (down)" do
        context "if the winning sequence starts at an edge" do
          let(:game_diag_down){described_class.new([1,1,1,1,3,2,2,2,2,3,3,4])}
          it "returns true" do
            expect(game_diag_down).to have_winner
          end
        end

        context "if the winning sequence does not start at an edge" do
          let(:game_diag_down){described_class.new([2,3,4,5,2,2,2,2,4,3,3,3,3,4,4,5])}
          it "returns true" do
            expect(game_diag_down).to have_winner
          end
        end
      end
    end

    context "when there is no winner" do
      let(:game_no_win){described_class.new([1,1,4,3,5,7,6,2])}
      
      it "returns false" do
        expect(game_no_win).not_to have_winner
      end
    end

    context "when there is no winner" do
      let(:game_no_win){described_class.new([1,2,3,4,5,1,2,3,4,5,1,2,3,4,5])}
      
      it "returns false" do
        expect(game_no_win).not_to have_winner
      end
    end
  end

  # describe "#handle_input" do
  #   context "when input is a digit from 1 to 7" do
  #     context "if the column is not full" do
  #       let(:game_handle_valid_input){described_class.new([1,2,2])}
  #       it "changes the appropriate column" do
  #         # expected = expect {game_handle_valid_input.handle_input("2"))}
  #         # expected.to change {game_handle_valid_input.col_to_string("2")}
  #       end

  #       it "switches current player" do

  #       end


  #     end

  #     context "if the row is full"
  #   end
  # end
end