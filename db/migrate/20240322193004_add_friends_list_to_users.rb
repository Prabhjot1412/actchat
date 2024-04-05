class AddFriendsListToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :friends_list, :jsonb, default: {}
  end
end
