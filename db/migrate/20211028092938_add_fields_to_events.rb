class AddFieldsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :venue, :string
    add_column :events, :description, :text
  end
end
