ActiveAdmin.register SettingRole do

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

  menu false
  menu parent: 'Admin'
  permit_params :group_role_id,:permission,:access,:model_access

  index do
    selectable_column
    column :id
    column :group_role
    column :permission
    column :access
    column :model_access
    actions
  end

end
