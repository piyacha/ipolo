class AddStuffProductImgToStuff < ActiveRecord::Migration
  def change
    add_attachment :stuffs, :stuff_product_img
  end
end
