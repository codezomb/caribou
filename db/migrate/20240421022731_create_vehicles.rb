class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles, primary_key: [:year, :make, :model] do |t|
      t.integer  :year
      t.string   :make
      t.string   :model
      t.integer  :msrp
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
