class AddCustomNametoStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :custom_name, :string, default: "MALE"
  end
end
