class AddImageToStaticValue < ActiveRecord::Migration
  def change
    add_attachment :static_values, :image
  end
end
