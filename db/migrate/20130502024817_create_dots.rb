class CreateDots < ActiveRecord::Migration
  def change
    create_table :dots do |t|
      t.string :latitude, :null => false
      t.string :longitude, :null => false
      t.references :production

      t.timestamps
    end
    add_index :dots, :production_id
  end
end
