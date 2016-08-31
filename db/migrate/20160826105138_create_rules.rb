class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :name
      t.text :description
      t.integer :state
      t.text :conditionType

      t.timestamps null: false
    end
  end
end
