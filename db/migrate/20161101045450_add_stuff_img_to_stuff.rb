class AddStuffImgToStuff < ActiveRecord::Migration
  def change
    add_attachment :stuffs, :stuff_img
  end
end
