class CreateStreamers < ActiveRecord::Migration[6.1]
  def change
    create_table :streamers do |t|
      t.string :name
    end
  end
end
