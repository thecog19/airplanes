class CreateAirplanes < ActiveRecord::Migration[5.0]
  def change
    create_table :airplanes do |t|
      t.string :name
      t.string :passenger
      t.string :size
      t.integer :priority
      t.timestamps
    end
  end
end
