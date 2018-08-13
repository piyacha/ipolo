ActiveAdmin.register StuffColor do

  menu parent: 'Stuff'

  permit_params :name, :color_code, :active, :priority ,:stuff_type_id ,:color_layer,:stuff_id,:color_price

  index do
    selectable_column
    # column :id
    column :stuff_type
    column :name
    column :color_layer
    column :color_code
    column "ราคาสีผ้า" do |stuff_color|
      if stuff_color.color_price
        stuff_color.color_price
      end
    end
    column :priority
    column :active
    actions
  end

  show do |c|
    attributes_table do
      row :stuff_type
      row :name
      row :color_layer
      row :color_code
      row "ราคาสีผ้า" do
        c.color_price
      end
      row :priority
      row :active
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :stuff_type
      f.input :name
      f.input :color_layer
      f.input :color_code
      f.input :color_price, :label => "ราคาสีผ้า"
      f.input :priority
      f.input :active
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
