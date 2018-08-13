class CreateGroupRoles < ActiveRecord::Migration
  def change
    create_table :group_roles do |t|
      t.string :name, default: ""
      t.timestamps null: false
    end
  end
end
