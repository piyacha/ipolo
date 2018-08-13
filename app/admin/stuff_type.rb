ActiveAdmin.register StuffType do

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
  actions :all, :except => [:new]

  permit_params :name, :desc, :stuff_type_img, :order, :active ,:priority,:custom_name,:delete_stuff_button

  index do
    selectable_column
    # column :id
    column :stuff_type_img do |stuff_img|
      if stuff_img.stuff_type_img
        image_tag(stuff_img.stuff_type_img.url(:thumb))
      end
    end
    # column :name
    column :custom_name
    column :delete_stuff_button
    column :active
    column :priority
    column :desc

    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :custom_name
      f.input :delete_stuff_button
      f.input :active
      f.input :priority
      f.input :desc
      f.input :stuff_type_img
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end



end
