class AddMaxWhToStuffLogo < ActiveRecord::Migration
  def change
    add_column :stuff_logos, :max_height, :float, default: 0
    add_column :stuff_logos, :max_width, :float, default: 0
  end
end
