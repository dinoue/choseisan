class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :memo
      t.references :user

      t.timestamps
    end
  end
end
