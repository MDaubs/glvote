class AddActiveBallotToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :active_ballot_id, :integer
  end
end
