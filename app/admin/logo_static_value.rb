ActiveAdmin.register LogoStaticValue do
  menu parent: 'Static Value'

  filter :name

  permit_params  :name,:logo_type,:amount,:value,:active,:custom_name

  index do
    selectable_column
    # column :id
    # column :name
    column :name
    column :custom_name
    # column :amount
    column :value
    column :active
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name, as: :select, collection:["A","B","C","D","E","F","G","H"]
      f.input :custom_name
      # f.input :logo_type
      f.input :logo_type, as: :select, collection:["screen","lace"]
      # f.input :amount
      f.input :value
      f.input :active
    end
    f.actions
  end

end
