class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.string :name
      t.integer :num

      t.timestamps null: false
    end
  end
end
