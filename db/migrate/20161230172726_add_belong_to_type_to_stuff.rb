class AddBelongToTypeToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :belong_to_type, :string, default: ""
  end
end
