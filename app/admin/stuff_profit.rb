ActiveAdmin.register StuffProfit do

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

  menu parent: 'Static Value'

  permit_params  :name,:active,:amount,:profit

  index do
    selectable_column
    # column :id
    # column :name
    column :amount
    column :profit
    column :active
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      # f.input :name
      f.input :amount
      f.input :profit
      f.input :active
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
