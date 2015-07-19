class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :site
      t.integer :rating
      t.text :review
      t.string :semantics
      t.references :merchant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
