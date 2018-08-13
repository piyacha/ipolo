class AddStuffToStuffColor < ActiveRecord::Migration
  def change
    add_reference :stuff_colors, :stuff, index: true
  end
end
