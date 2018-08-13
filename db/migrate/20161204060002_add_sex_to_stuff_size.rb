class AddSexToStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :sex, :string, default: "male"
  end
end
