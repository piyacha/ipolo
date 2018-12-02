ActiveAdmin.register StaticValue do
  menu parent: 'Static Value',  priority: 0
  
  permit_params  :key, :value, :active ,:image, :remove_image

  index do
    selectable_column
    column "key" do |sv|
      if sv.key
        sv.key
      end
    end
    column "value" do |sv|
      if sv.value
        sv.value
      end
    end
    column "image" do |sv_img|
      if sv_img.image
        image_tag(sv_img.image.url(:thumb))
      end
    end
    column :active
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :key, label: "key"
      f.input :value, label: "value"
      f.input :active, label: "เปิด / ปิด"
      f.input :image, :image_preview => true, label: "รูปที่แสดง"
      f.input :remove_image, as: :boolean, required: false, label: "Remove Image"
    end
    f.actions
  end

end
