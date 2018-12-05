ActiveAdmin.register BankAccount do
  permit_params :no, :name, :active, :image, :remove_image, :branch, :bank_name

  menu parent: 'Payment'

  filter :active

  index do
    selectable_column
    id_column
    column :image do |bank|
      if bank.image
        image_tag(bank.image.url(:thumb),style:'width:80px;')
      end
    end
    column :no
    column :branch
    column :bank_name
    column :name
    column :active
    actions
  end

  form do |f|
    f.inputs "Bank Account Details" do
      f.input :image, :image_preview => true, label: "รูปที่แสดง"
      f.input :remove_image, as: :boolean, required: false, label: "Remove Image"
      f.input :no
      f.input :name
      f.input :branch
      f.input :bank_name
      f.input :active
    end
    f.actions
  end
end
