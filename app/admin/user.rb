ActiveAdmin.register User do

  permit_params :email, :name, :phone

  filter :email

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :phone
    column :sign_in_count
    column :last_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :phone
    end
    f.actions
  end

end
