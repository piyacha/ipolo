ActiveAdmin.register StuffTexture do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  menu parent: 'Stuff'

  permit_params :name, :priority, :stuff_texture_img, :active ,:stuff_id ,:price ,:status_flexible ,:status_thick ,:status_velvety,:consumption,:desc

  index do
    selectable_column
    # column :id
    column :stuff_texture_img do |stuff_img|
      if stuff_img.stuff_texture_img
        image_tag(stuff_img.stuff_texture_img.url(:thumb))
      end
    end
    column :stuff
    column :name
    column :desc
    column "ราคาของผ้า" do |texture|
      if texture.price
        texture.price
      end
    end
    column :consumption
    column :status_flexible
    column :status_thick
    column :status_velvety
    column :active
    column :priority

    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :stuff
      f.input :name
      f.input :desc
      f.input :price, :label => "ราคาของผ้า"
      f.input :consumption
      f.input :status_flexible
      f.input :status_thick
      f.input :status_velvety
      f.input :active
      f.input :priority
      f.input :stuff_texture_img
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
