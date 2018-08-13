class CreateSettingRoles < ActiveRecord::Migration
  def change
    create_table :setting_roles do |t|
      t.string :permission, default: ""
      t.string :access, default: ""
      t.string :model_access, default: ""
      t.timestamps null: false
    end
  end
end
