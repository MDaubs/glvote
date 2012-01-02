class AddVoterNameConfirmedToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :voter_name_confirmed, :boolean, :default => false
  end
end
