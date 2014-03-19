class AddIndexesToAttendances < ActiveRecord::Migration
  def change
    add_index :attendances, :user_id
    add_index :attendances, :show_id
  end
end
