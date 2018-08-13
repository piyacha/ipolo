class AddStuffTypeToStuffSize < ActiveRecord::Migration
  def change
    add_reference :stuff_sizes, :stuff_type, index: true
  end
end
