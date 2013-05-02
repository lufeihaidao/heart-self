class CreateUserProductions < ActiveRecord::Migration
  def change
    create_table :user_productions do |t|
      t.integer :user_id
      t.integer :production_id, :null => false
      t.datetime :order_at, :null => false
      t.integer :bargain_price, :null => false
      t.boolean :is_loved, :default => false
      t.boolean :is_sold, :default => false
      t.datetime :sold_at, :default => Time.new("3000")

      t.timestamps
    end
  end
end
