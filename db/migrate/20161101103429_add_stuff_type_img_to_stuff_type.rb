class AddStuffTypeImgToStuffType < ActiveRecord::Migration
  def change
    add_attachment :stuff_types, :stuff_type_img
  end
end
