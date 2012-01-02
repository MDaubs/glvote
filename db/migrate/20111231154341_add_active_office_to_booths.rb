class AddActiveOfficeToBooths < ActiveRecord::Migration
  def change
    add_column :booths, :active_office_id, :integer
  end
end
