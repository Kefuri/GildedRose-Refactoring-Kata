class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if is_sulfuras?(item)
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      elsif item.name == "Aged Brie"
        update_aged_brie(item)
      else
        update_other(item)
      end
    end
  end

  def is_sulfuras?(item)
    if item.name == "Sulfuras, Hand of Ragnaros"
      return true
    end
    return false
  end

  def increase_quality_if_not_max(item)
    if item.quality < 50
      item.quality += 1
    end
  end

  def decrease_quality_if_not_zero(item)
    if item.quality > 0
      item.quality -= 1
    end
  end

  def backstage_pass_additional_increase_quality(item)
    if item.sell_in < 11
      increase_quality_if_not_max(item)
    end
    if item.sell_in < 6
      increase_quality_if_not_max(item)
    end
  end

  def aged_brie_additional_increase_quality(item)
    increase_quality_if_not_max(item) if item.sell_in < 0
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end

  def check_backstage_expiry_date(item)
    if item.sell_in < 0
      item.quality = 0
    end
  end

  def update_backstage_passes(item)
    increase_quality_if_not_max(item)
    backstage_pass_additional_increase_quality(item)
    decrease_sell_in(item)
    check_backstage_expiry_date(item)
  end

  def update_aged_brie(item)
    increase_quality_if_not_max(item)
    decrease_sell_in(item)
    aged_brie_additional_increase_quality(item)
  end

  def update_other(item)
    decrease_quality_if_not_zero(item)
    decrease_sell_in(item)
    decrease_quality_if_not_zero(item) if item.sell_in < 0
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end