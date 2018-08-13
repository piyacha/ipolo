class AddAdditionalPriceToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :additional_price, :string, default: ""
  end
end
