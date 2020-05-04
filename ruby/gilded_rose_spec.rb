require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "will not change item quality on sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "will not decrease sell in on sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it "increases item quality of backstage pass once" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 14, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 41
    end

    it "increases item quality of backstage pass twice when 10 days till sell_in" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 42
    end

    it "increases item quality of backstage pass 3 times when 5 days till sell_in" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 43
    end

    it "decreases item quality of backstage pass to 0 when the concert date passes" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "does not increase backstage pass in value over 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "increase quality of brie by 1 before sell in" do
      items = [Item.new("Aged Brie", 2, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 41
    end

    it "increases quality of Brie after sell in" do
      items = [Item.new("Aged Brie", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "decreases quality of other item every day" do
      items = [Item.new("Copy of Akiba's Trip", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end

    it "decreases quality of other item by 2 once past sell in" do
      items = [Item.new("Copy of Akiba's Trip", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end
  end
end
