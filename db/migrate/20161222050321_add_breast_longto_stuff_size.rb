class AddBreastLongtoStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :breast, :string, default: ""
    add_column :stuff_sizes, :long, :string, default: ""
  end
end
