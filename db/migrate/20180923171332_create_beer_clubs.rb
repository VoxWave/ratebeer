class CreateBeerClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :beer_clubs do |t|
      t.string :name
      t.integer :founded

      t.timestamps
    end
  end
end
