class AddAdminToEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :events, :admin, null: false, foreign_key: { to_table: :users }
  end
end
