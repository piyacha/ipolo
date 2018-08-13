class AddCustomNameToLogoStaticValue < ActiveRecord::Migration
  def change
    add_column :logo_static_values, :custom_name, :string, default: ""
  end
end
