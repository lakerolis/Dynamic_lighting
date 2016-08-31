class AddValueToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :value, :text
  end
end
