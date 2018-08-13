class AddColorNumberToStuffLogo < ActiveRecord::Migration
  def change
    add_column :stuff_logos, :color_number, :string, default: ""
  end
end
