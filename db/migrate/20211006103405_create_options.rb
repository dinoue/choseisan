class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :text, null: false
      t.references :event, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
