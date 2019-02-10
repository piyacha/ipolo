ActiveAdmin.register BankAccount do
  permit_params :no, :name, :active, :image, :remove_image, :branch, :bank_name

  menu parent: 'Payment'

  filter :active

  index do
    selectable_column
    id_column
    column "โลโก้ธนาคาร" do |bank|
      if bank.image
        image_tag(bank.image.url(:thumb),style:'width:80px;')
      end
    end
    column "เลขบัญชีธนาคาร" do |bank|
      bank.no
    end
    column "สาขา" do |bank|
      bank.branch
    end
    column "ชื่อธนาคาร" do |bank|
      bank.bank_name
    end
    column "ชื่อเจ้าจองบัญชี" do |bank|
      bank.name
    end
    column :active
    actions
  end

  form do |f|
    f.inputs "Bank Account Details" do
      f.input :image, :image_preview => true, label: "โลโก้ธนาคาร"
      f.input :remove_image, as: :boolean, required: false, label: "Remove Image"
      f.input :no, label: "เลขบัญชีธนาคาร"
      f.input :name, label: "ชื่อเจ้าจองบัญชี"
      f.input :branch, label: "สาขา"
      f.input :bank_name, label: "ชื่อธนาคาร"
      f.input :active
    end
    f.actions
  end
end
