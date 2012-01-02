class CreateBallots < ActiveRecord::Migration
  def up
    create_table :ballots do |t|
      t.timestamps
    end
  end

  def down
    drop_table :ballots
  end
end
