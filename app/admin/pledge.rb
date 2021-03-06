ActiveAdmin.register Pledge do

  menu parent: 'Static Value',label: 'Deposit'
  show title: 'Deposit'
  permit_params  :name,:value,:priority,:active,:custom_name

  controller do
    def edit
      @page_title = "Deposit "+resource.name
    end
  end

  index do
    selectable_column
    # column :id
    column :custom_name
    column :value
    column :priority
    column :active

    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :value
      f.input :priority
      f.input :active
      f.input :custom_name
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
