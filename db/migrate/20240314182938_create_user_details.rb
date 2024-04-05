class CreateUserDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :user_details do |t|
      t.string :user_name
      t.bigint :user_id

      t.timestamps
    end
  end
end
