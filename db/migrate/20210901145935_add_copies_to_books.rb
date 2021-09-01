class AddCopiesToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :copies, :integer, default: 0
  end
end
