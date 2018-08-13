class AddOptionPricetoStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :add_option_price, :float, default: 0
  end
end
