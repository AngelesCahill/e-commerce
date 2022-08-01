class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.string :state
      t.string :token
      t.integer :total

      t.timestamps
    end
  end
end
