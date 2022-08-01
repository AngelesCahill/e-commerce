class CreateCurrentOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :current_orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
