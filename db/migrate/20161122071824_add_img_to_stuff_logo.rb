class AddImgToStuffLogo < ActiveRecord::Migration
  def change
    add_attachment :stuff_logos, :stuff_logo_img
  end
end
