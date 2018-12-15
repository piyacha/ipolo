ActiveAdmin.register StuffExist do
  menu false
  # menu parent: 'Existed',  priority: 1

  permit_params  :name, :desc, :size, :active ,:stuff_exist_img, :remove_stuff_exist_img,stuff_exist_size_attributes: [:id, :name, :sex, :priority,:price, :_destroy]

  index do
    selectable_column
    # column :id
    column "ชื่อที่แสดง" do |stuff|
      if stuff.name
        stuff.name
      end
    end
    column "รายละเอียด" do |stuff|
      if stuff.desc
        stuff.desc
      end
    end
    # column :size
    column "รูปที่แสดง" do |stuff_img|
      if stuff_img.stuff_exist_img
        image_tag(stuff_img.stuff_exist_img.url(:thumb))
      end
    end
    column :active
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name, label: "ชื่อที่แสดง"
      # f.input :size
      f.input :desc, label: "รายละเอียด"
      f.input :active, label: "เปิด / ปิด"
      f.input :stuff_exist_img, :image_preview => true, label: "รูปที่แสดง"
      f.input :remove_stuff_exist_img, as: :boolean, required: false, label: "Remove Image"
    end

    f.has_many :stuff_exist_size do |stuff_exist|
      stuff_exist.input :name,   :wrapper_html => { :class => 'admin-inline' }
      stuff_exist.input :sex, as: :select, collection:["male","female"],   :wrapper_html => { :class => 'admin-inline' }
      stuff_exist.input :price,   :wrapper_html => { :class => 'admin-inline' }
      stuff_exist.input :priority,   :wrapper_html => { :class => 'admin-inline' }
      stuff_exist.input :_destroy, as: :boolean,   :wrapper_html => { :class => 'admin-inline' }
    end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end




end
