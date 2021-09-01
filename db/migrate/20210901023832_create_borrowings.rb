class CreateBorrowings < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowings do |t|
      t.references  :user, index: true, foreign_key: true
      t.references  :book, index: true, foreign_key: true
      t.date        :borrowed_date
      t.date        :return_date

      t.timestamps
    end
  end
end
