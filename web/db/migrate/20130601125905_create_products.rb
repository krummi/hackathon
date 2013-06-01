class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :is_per_kg

      t.timestamps
    end
  end
end
