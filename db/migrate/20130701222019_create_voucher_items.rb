class CreateVoucherItems < ActiveRecord::Migration
  def up
    create_table :voucher_items do |t|
      t.references :voucher, index: true
      t.string :description

      t.timestamps
    end

    add_money :voucher_items, :amount, allow_nil: false
  end
  def down
    drop_table :voucher_items
  end
end
