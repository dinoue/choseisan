class AddStatusToOption < ActiveRecord::Migration[6.1]
  def change
    add_column :options, :status, :integer, null: false, default: 0, after: :text
  end
end
