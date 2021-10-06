class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :text
      t.integer :event_id

      t.timestamps
    end
  end
end
