class GroupRole < ActiveRecord::Base

  has_many :setting_role

  def self.enable_access_control
    true
  end

  def self.getAllModel
    models = []
    ActiveRecord::Base.descendants.each do |klass|
      if klass.to_s != "ActiveAdmin::Comment" && klass.to_s != "ActiveRecord::SchemaMigration"
        if klass.enable_access_control
          models.append(klass.name)
        end
      end
    end
    return models
  end

end
