class AddAddressFieldsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :country, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :flaot
  end
end
