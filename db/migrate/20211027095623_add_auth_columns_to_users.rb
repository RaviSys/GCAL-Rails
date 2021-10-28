class AddAuthColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :access_token, :string
    add_column :users, :expires_at, :integer
    add_column :users, :refresh_token, :string
  end
end
