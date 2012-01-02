class CreateBallotSelections < ActiveRecord::Migration
  def up
    create_table :ballot_selections do |t|
      t.integer :ballot_id
      t.integer :candidate_id
      t.timestamps
    end
  end

  def down
    drop_table :ballot_selections
  end
end
