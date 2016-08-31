class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.text :name
      t.text :description
      t.text :operator
      t.text :operator_value
      t.references :sensor, index: true, foreign_key: true
      t.references :rule, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
