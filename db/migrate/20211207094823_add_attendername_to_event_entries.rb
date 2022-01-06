class AddAttendernameToEventEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :event_entries, :attendername, :string, null: false, limit: 30
  end
end
