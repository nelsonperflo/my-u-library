class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :email
      t.string    :password_digest

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, [:first_name, :last_name]

  end
end
