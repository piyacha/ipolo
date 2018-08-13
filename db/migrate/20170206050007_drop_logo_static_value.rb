class DropLogoStaticValue < ActiveRecord::Migration
  def change
    drop_table :logo_static_value
  end
end
