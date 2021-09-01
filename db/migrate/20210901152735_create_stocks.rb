class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references  :book, index: { unique: true }, foreign_key: true
      t.integer     :quantity

      t.timestamps
    end
  end
end
