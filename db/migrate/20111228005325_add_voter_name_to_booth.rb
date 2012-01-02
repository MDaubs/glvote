class AddVoterNameToBooth < ActiveRecord::Migration
  def change
    add_column :booths, :voter_name, :string
  end
end
