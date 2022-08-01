class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :number
      t.integer :total
      t.string :state

      t.timestamps
    end
  end
end