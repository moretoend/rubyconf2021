class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :tier
      t.references :user, null: false, foreign_key: true
      t.references :streamer, null: false, foreign_key: true
    end
  end
end
