class AddGuestListToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :guest_list, :string
  end
end
