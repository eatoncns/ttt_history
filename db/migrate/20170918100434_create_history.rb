class CreateHistory < ActiveRecord::Migration[5.1]
  def change
    create_table :history do |t|
      t.integer :player_id
      t.string :board
      t.datetime :timestamp
    end
  end
end
