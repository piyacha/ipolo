ActiveAdmin.register StuffExistSize do

  # menu parent: 'Existed',  priority: 2
  menu false

  permit_params :name, :sex, :priority, :price,:stuff_exist_id

  index do
    selectable_column
    # column :id
    column :stuff_exist
    column :name
    column :sex
    column :price
    column :priority
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :stuff_exist
      f.input :name
      f.input :sex
      f.input :price
      f.input :priority
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
