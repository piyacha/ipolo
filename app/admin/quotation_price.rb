ActiveAdmin.register QuotationPrice do

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
#   menu parent: 'Order',  priority: 3
  menu false

  permit_params :name, :amount, :price, :quotation_id

  index do
    selectable_column
    # column :id
    column :quotation
    column :name
    column :amount
    column :price
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :quotation
      f.input :name
      f.input :amount
      f.input :price
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
