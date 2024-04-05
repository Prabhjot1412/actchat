class CreateUserDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :user_details do |t|
      t.string :user_name
      t.bigint :user_id

      t.timestamps
    end

    add_index :user_details, [:user_name, :user_id], unique: true, name: 'index_user_name_user_id'
  end
end
