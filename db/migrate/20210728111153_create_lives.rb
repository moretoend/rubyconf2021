class CreateLives < ActiveRecord::Migration[6.1]
  def change
    create_table :lives do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :streamer, null: false, foreign_key: true
    end
  end
end
