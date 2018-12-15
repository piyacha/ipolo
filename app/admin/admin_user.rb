ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :username, :anonymous,:group_role_id
  
  menu parent: 'Admin'

  filter :email
  filter :username

  index do
    selectable_column
    id_column
    column :group_role
    column :email
    column :username
    column :current_sign_in_at
    column :sign_in_count
    column :anonymous
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :group_role
      f.input :email
      f.input :username
      f.input :anonymous
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
