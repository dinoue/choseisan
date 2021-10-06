class CreateEventEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :event_entries do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.string :comment

      t.timestamps null: false
    end

    add_index :event_entries, [:event_id, :user_id], unique: true
    add_index :event_entries, [:user_id, :event_id], unique: true
  end
end
