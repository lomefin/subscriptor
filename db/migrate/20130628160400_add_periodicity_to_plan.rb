class AddPeriodicityToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :periodicity, :string, default: "monthly"
  end
end
