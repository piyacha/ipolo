class AddBasePriceToStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :base_price, :float, default: 1
  end
end
