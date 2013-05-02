class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.datetime :make_at, :null => false
      t.string :p_type, :null => false # facet or radial
      t.string :p_pattern, :null => false # necklace, earring, and so on
      t.string :p_material, :null => false # bamboo, metal or other
      t.string :p_color, :null => false
      t.string :p_size, :null => false
      t.integer :love_count, :null => false, :default => 0
      t.integer :price
      t.string :img_url

      t.timestamps
    end
  end
end
