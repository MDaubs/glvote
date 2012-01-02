class AddCastToBallots < ActiveRecord::Migration
  def change
    add_column :ballots, :cast, :boolean, :default => false
  end
end
