class AddpPatternPriceToStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :pattern_price, :float, default: 0
  end
end
