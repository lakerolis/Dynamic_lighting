class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.text :name
      t.text :config
      t.references :actor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
