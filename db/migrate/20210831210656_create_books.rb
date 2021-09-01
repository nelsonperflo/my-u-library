class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string    :title
      t.string    :author
      t.integer   :published_year
      t.string    :genre

      t.timestamps
    end
    add_index :books, :title
    add_index :books, :author
    add_index :books, :genre
  end
end
