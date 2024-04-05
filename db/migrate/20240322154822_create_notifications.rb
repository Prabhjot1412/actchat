class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :kind
      t.boolean :seen
      t.string :data
      t.bigint :receiver_id
      t.bigint :sender_id

      t.timestamps
    end
  end
end
