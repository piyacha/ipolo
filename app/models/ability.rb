class Ability < ActiveRecord::Base

  include CanCan::Ability

  def initialize(user)

    # can :read, ActiveAdmin::Page, :name => "Dashboard"
    # can :manage, AdminUser
    # can :manage, SettingRole
    # can :manage, GroupRole
    # can :manage, :all

    @permission = {}

    if user
      @models = []
      ActiveRecord::Base.descendants.each do |klass|
        if klass.to_s != "ActiveAdmin::Comment" && klass.to_s != "ActiveRecord::SchemaMigration"
          if klass.enable_access_control
            @models.append(klass)
          end
        end
      end

      if user.group_role_id == nil
        group_role = GroupRole.find_by(name:"superadmin")
      else
        group_role = GroupRole.find(user.group_role_id)
      end

      if group_role.name == "superadmin"
        can :manage, :all
      else
        for role_item in SettingRole.where(group_role_id: user.group_role_id)
          @permission[role_item.model_access] = []
        end

        for role_item in SettingRole.where(group_role_id: user.group_role_id)
          @permission[role_item.model_access].push(role_item.permission)
        end

        @permission.each do |model, permission|
          for item in permission
            role_permission = item.split("_")
            if role_permission.count > 1
              can role_permission[0].to_sym, model.constantize ,:create_user => user.id.to_s # access Owner
            else
              can item.to_sym, model.constantize
            end
          end
        end
      end
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    else
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    end

  end

  def self.enable_access_control
    false
  end

end
