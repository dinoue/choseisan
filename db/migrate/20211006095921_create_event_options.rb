class CreateEventOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :event_options do |t|
      t.string :option

      t.timestamps
    end
  end
end
