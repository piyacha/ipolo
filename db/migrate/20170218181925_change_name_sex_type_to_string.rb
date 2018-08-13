class ChangeNameSexTypeToString < ActiveRecord::Migration
  def change
    remove_column :stuff_exist_sizes, :name
    add_column :stuff_exist_sizes, :name, :string, default: ""
    remove_column :stuff_exist_sizes, :sex
    add_column :stuff_exist_sizes, :sex, :string, default: ""
  end
end
