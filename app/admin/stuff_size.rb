ActiveAdmin.register StuffSize do

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

  permit_params :name, :desc, :active ,:priority ,:stuff_id ,:base_price ,:sex ,:breast ,:long,:add_option_price,:custom_name,:pattern_price

  index do
    selectable_column
    # column :id
    column :stuff
    column :name
    # column :custom_name
    column :sex
    column :breast
    column :long
    column "ราคาไซส์ (Deviation)" do |size|
      if size.base_price
        size.base_price
      end
    end
    column "ราคาความยาว (%)" do |size|
      if size.add_option_price
        size.add_option_price
      end
    end
    column "Pattern price (ค่าคงที่เอาไปบวก)" do |size|
      if size.pattern_price
        size.pattern_price
      end
    end
    column :priority
    column :active

    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :stuff
      f.input :name
      # f.input :custom_name, :label => "custom sex"
      # f.input :sex
      f.input :sex, as: :select, collection:["male","female"]
      f.input :breast
      f.input :long
      f.input :base_price, :label => "ราคาไซส์ (Deviation)"
      f.input :add_option_price, :label => "ราคาความยาว (%)"
      f.input :pattern_price, :label => "Pattern price (ค่าคงที่เอาไปบวก)"
      f.input :priority
      f.input :active
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
