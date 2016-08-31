class CreateSensorInputs < ActiveRecord::Migration
  def change
    create_table :sensor_inputs do |t|
      t.text :sensor_id
      t.text :sensorvalue
      t.text :triggered

      t.timestamps null: false
    end
  end
end
