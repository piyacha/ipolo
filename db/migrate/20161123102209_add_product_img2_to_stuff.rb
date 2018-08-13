class AddProductImg2ToStuff < ActiveRecord::Migration
  def change
    add_attachment :stuffs, :stuff_product_img_two
  end
end
