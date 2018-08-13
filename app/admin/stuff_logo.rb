ActiveAdmin.register StuffLogo do

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



  # menu parent: 'Stuff'
  menu false

  permit_params  :stuff_logo_img,:color_number,:logo_type,:logo_width,:logo_height

  index do
    selectable_column
    # column :id
    column :stuff_logo_img do |stuff_img|
      if stuff_img.stuff_logo_img
        image_tag(stuff_img.stuff_logo_img.url(:thumb))
      end
    end
    column :color_number
    column :logo_type
    column :logo_width
    column :logo_height
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :stuff_logo_img
      f.input :color_number
      f.input :logo_type
      f.input :logo_width
      f.input :logo_height

    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end



end
