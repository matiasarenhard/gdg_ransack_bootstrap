class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.references :supplier, foreign_key: true
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
