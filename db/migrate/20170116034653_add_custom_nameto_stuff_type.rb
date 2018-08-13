class AddCustomNametoStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :custom_name, :string, default: ""
  end
end
