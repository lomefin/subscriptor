class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.references :subscription, index: true
      t.date :due_date
      t.date :fulfilled
      t.string :payment_id

      t.timestamps
    end
  end
end
