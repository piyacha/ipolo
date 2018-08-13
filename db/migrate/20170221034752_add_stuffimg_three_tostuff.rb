class AddStuffimgThreeTostuff < ActiveRecord::Migration
  def change
    add_attachment :stuffs, :stuff_product_img_three
  end
end
