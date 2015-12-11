class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :username, :string, default: "anonymous"
  end
end
