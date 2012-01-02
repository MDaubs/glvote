class AddBeginPressedToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :begin_pressed, :boolean, :default => false
  end
end
