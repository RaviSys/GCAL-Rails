class AddGoogleEventToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :google_event_id, :string
  end
end
