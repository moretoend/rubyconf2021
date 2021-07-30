class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.datetime :send_date
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :live, null: false, foreign_key: true
    end
  end
end
