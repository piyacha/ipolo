class AddStuffToStuffSize < ActiveRecord::Migration
  def change
    add_reference :stuff_sizes, :stuff, index: true
  end
end
