require './gilded_rose.rb'
require "rspec"

describe GildedRose do
  let(:gilded_rose) { GildedRose.new }

  #
  # This is a shared example for running the same test multiple times
  # with different parameters.
  #
  shared_examples "an item" do |item_name, updates|
    subject { gilded_rose.items.find { |i| i.name == item_name } }
    it { should be_an Item }

    updates.each do |(num_updates, expected_sell_in, expected_quality)|
      context "updating the quality #{num_updates} times" do
        before do
          num_updates.times do
            gilded_rose.update_quality
          end
        end

        its(:sell_in) { should == expected_sell_in }
        its(:quality) { should == expected_quality }
      end
    end
  end

  #
  # We need to be able to check the items, so make this a requirement it { should respond_to :items }
  #
  context "the items" do
    subject { gilded_rose.items }

    its(:length) { should == 6 }
    its(:first) { should be_an Item }
  end

  context "the +5 Dexterity Vest" do
    it_behaves_like "an item", "+5 Dexterity Vest",
      # [ number of updates, expected sell in, expected quality ]
      [[1, 9, 19],
       [10, 0, 10],
       [11, -1, 8],
       [12, -2, 6],
       [16, -6, 0]]
  end

  context "the Aged Brie" do
    it_behaves_like "an item", "Aged Brie",
      [[1, 1, 1],
       [2, 0, 2],
       [3, -1, 4],
       [51, -49, 50],
       [52, -50, 50]]
  end

  context "the Elixir of the Mongoose" do
    it_behaves_like "an item", "Elixir of the Mongoose",
      [[1, 4, 6],
       [2, 3, 5],
       [6, -1, 0],
       [7, -2, 0]]
  end

  context "the Sulfuras, Hand of Ragnaros" do
    it_behaves_like "an item", "Sulfuras, Hand of Ragnaros",
      [[1, 0, 80],
       [2, 0, 80],
       [100, 0, 80]]
  end

  # Good luck with this one.
  context "the Backstage passes blah blah" do
    it_behaves_like "an item", "Backstage passes to a TAFKAL80ETC concert",
      [[1, 14, 21],
       [2, 13, 22],
       [5, 10, 25],
       [6, 9, 27],
       [7, 8, 29],
       [11, 4, 38],
       [12, 3, 41],
       [15, 0, 50],
       [16, -1, 0],
       [100, -85, 0]]
  end

  #
  # The following is the requested system update to handle conjured items.
  # Uncomment when you're ready.
  #
  context "the Conjured Mana Cake" do
    #it_behaves_like "an item", "Conjured Mana Cake",
    #  [[1, 2, 4],
    #   [2, 1, 2],
    #   [3, 0, 0],
    #   [4, -1, 0]]
  end
end
