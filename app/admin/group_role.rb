ActiveAdmin.register GroupRole do

  menu parent: 'Admin'

  permit_params :name

  controller do

    def create
      setUpRole
      redirect_to admin_group_roles_path
    end

    def update
      @group_role = GroupRole.where({id: params[:id]}).first
      @group_role.name = params[:group_role]['name']
      @group_role.save
      setUpRole
      redirect_to admin_group_roles_path
    end

    private
    def setUpRole

      if params[:id]
        SettingRole.where({group_role_id: params[:id]}).destroy_all
        group_role_id = params[:id]
      else
        group_role  =  GroupRole.new
        group_role.name = params[:group_role]['name']
        group_role.save
        group_role_id = group_role.id
      end
      group_role = GroupRole.find(group_role_id)


      for page in GroupRole.getAllModel()
        if params[page]
          params[page].each do |page_item|
            if page_item != ""
              setting_role = SettingRole.new
              setting_role.model_access = page
              setting_role.group_role = group_role
              setting_role.permission = page_item
              if page_item =="update_owner"
                setting_role.access = "owner"
              elsif page_item =="read_owner"
                setting_role.access = "owner"
              elsif page_item =="destroy_owner"
                setting_role.access = "owner"
              else
                setting_role.access = "all"
              end
              setting_role.save
            end
          end
        end
      end

    end

  end

  index do
    selectable_column
    column :id
    column :name
    actions
  end

  show do |c|
    attributes_table do
      row :name
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
    end

    f.inputs 'Add Permission' do
      div :class => "panel_contents" do
        div :class => "attributes_table" do
          table do
            tr do
              th do
                span style:"margin-left:10px;" do
                  "Models"
                end
              end
              th do
                "Manage"
              end
              th do
                "Create"
              end
              th do
                "Update"
              end
              th do
                "Update Owner"
              end
              th do
                "Read"
              end
              th do
                "Read Owner"
              end
              th do
                "Destroy"
              end
              th do
                "Destroy Owner"
              end
            end
            for page in GroupRole.getAllModel()
              if page != nil
                tr do
                  th do
                    span style:"margin-left:10px;" do
                      page
                    end
                  end
                  setting_role = SettingRole.where({model_access: page,group_role_id: params[:id]})
                  role_item = {}
                  if !setting_role.nil?
                    setting_role.each do |each_role|
                      role_item[each_role.permission.to_sym] = each_role.permission
                    end
                  end
                  th do
                    if role_item[:manage].nil?
                      check_box_tag page.to_s+"[]", 'manage', false
                    else
                      check_box_tag page.to_s+"[]", 'manage', true
                    end
                  end
                  th do
                    if role_item[:create].nil?
                      check_box_tag page.to_s+"[]", 'create', false
                    else
                      check_box_tag page.to_s+"[]", 'create', true
                    end
                  end
                  th do
                    if role_item[:update].nil?
                      check_box_tag page.to_s+"[]", 'update', false
                    else
                      check_box_tag page.to_s+"[]", 'update', true
                    end
                  end
                  th do
                    if role_item[:update_owner].nil?
                      check_box_tag page.to_s+"[]", 'update_owner', false
                    else
                      check_box_tag page.to_s+"[]", 'update_owner', true
                    end
                  end
                  th do
                    if role_item[:read].nil?
                      check_box_tag page.to_s+"[]", 'read', false
                    else
                      check_box_tag page.to_s+"[]", 'read', true
                    end
                  end
                  th do
                    if role_item[:read_owner].nil?
                      check_box_tag page.to_s+"[]", 'read_owner', false
                    else
                      check_box_tag page.to_s+"[]", 'read_owner', true
                    end
                  end
                  th do
                    if role_item[:destroy].nil?
                      check_box_tag page.to_s+"[]", 'destroy', false
                    else
                      check_box_tag page.to_s+"[]", 'destroy', true
                    end
                  end
                  th do
                    if role_item[:destroy_owner].nil?
                      check_box_tag page.to_s+"[]", 'destroy_owner', false
                    else
                      check_box_tag page.to_s+"[]", 'destroy_owner', true
                    end
                  end
                end
              end
            end

          end
        end
      end
    end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
