class AddStuffExistImgtoStuffExist < ActiveRecord::Migration
  def change
    add_attachment :stuff_exists, :stuff_exist_img
  end
end
