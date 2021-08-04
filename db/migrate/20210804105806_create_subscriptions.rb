class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :user_name
      t.string :user_email
      t.references :event, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
