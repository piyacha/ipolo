class AddStuffTypeToStuffColor < ActiveRecord::Migration
  def change
    add_reference :stuff_colors, :stuff_type, index: true
  end
end
