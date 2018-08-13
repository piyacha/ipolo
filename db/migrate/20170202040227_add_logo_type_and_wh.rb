class AddLogoTypeAndWh < ActiveRecord::Migration
  def change
    add_column :stuff_logos, :logo_type, :string, default: ""
    add_column :stuff_logos, :logo_width, :string, default: ""
    add_column :stuff_logos, :logo_height, :string, default: ""
  end
end
