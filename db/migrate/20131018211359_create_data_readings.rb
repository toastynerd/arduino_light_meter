class CreateDataReadings < ActiveRecord::Migration
  def change
    create_table :data_readings do |t|
      t.integer :red
      t.integer :green
      t.integer :blue
      t.integer :white

      t.timestamps
    end
  end
end
