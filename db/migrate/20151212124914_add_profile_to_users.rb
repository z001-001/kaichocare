class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :location, :string
    add_column :users, :url, :string
  end
end
