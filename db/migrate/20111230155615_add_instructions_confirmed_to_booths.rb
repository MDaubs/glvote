class AddInstructionsConfirmedToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :instructions_confirmed, :boolean, :default => false
  end
end
