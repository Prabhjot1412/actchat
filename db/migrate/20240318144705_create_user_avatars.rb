class CreateUserAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :user_avatars do |t|
      t.bigint :user_id
      t.bigint :avatar_id

      t.timestamps
    end
  end
end
