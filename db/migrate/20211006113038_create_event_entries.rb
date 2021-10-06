class CreateEventEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :event_entries do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
