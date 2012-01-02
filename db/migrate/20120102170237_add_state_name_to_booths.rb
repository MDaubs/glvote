class AddStateNameToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :state_name, :string, :default => 'inactive_state'
  end
end
