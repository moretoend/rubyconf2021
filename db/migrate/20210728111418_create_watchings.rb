class CreateWatchings < ActiveRecord::Migration[6.1]
  def change
    create_table :watchings do |t|
      t.integer :duration_in_seconds
      t.references :user, null: false, foreign_key: true
      t.references :live, null: false, foreign_key: true
    end
  end
end
