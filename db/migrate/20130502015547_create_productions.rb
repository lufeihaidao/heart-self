class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.date :make_at, :null => false
      t.string :p_type, :null => false
      t.string :p_pattern, :null => false
      t.string :p_color, :null => false
      t.string :p_size, :null => false
      t.integer :love_count, :null => false, :default => 0
      t.string :img_url

      t.timestamps
    end
  end
end
