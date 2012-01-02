class CreateCandidates < ActiveRecord::Migration
  def up
    create_table :candidates do |t|
      t.string  :name
      t.integer :office_id
    end
  end

  def down
    drop_table :candidates
  end
end
