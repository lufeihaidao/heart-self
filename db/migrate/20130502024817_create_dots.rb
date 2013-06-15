class CreateDots < ActiveRecord::Migration
  def change
    create_table :dots do |t|
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.string :city_name, :null => false
      t.references :production

      t.timestamps
    end
    add_index :dots, :production_id
  end
end
