class CreateBooths < ActiveRecord::Migration
  def up
    create_table :booths do |t|
    end
  end

  def down
    drop_table :booths
  end
end
