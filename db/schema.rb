# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130724200808) do

  create_table "customers", force: true do |t|
    t.integer  "product_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["product_id"], name: "index_customers_on_product_id"

  create_table "discounts", force: true do |t|
    t.integer  "applied_to"
    t.string   "unit"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_pesos",    default: 0,     null: false
    t.string   "value_currency", default: "CLP", null: false
    t.integer  "position"
  end

  add_index "discounts", ["plan_id"], name: "index_discounts_on_plan_id"

  create_table "item_charges", force: true do |t|
    t.string   "description"
    t.date     "due"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost_pesos",    default: 0,     null: false
    t.string   "cost_currency", default: "CLP", null: false
  end

  add_index "item_charges", ["plan_id"], name: "index_item_charges_on_plan_id"

  create_table "plans", force: true do |t|
    t.string   "name"
    t.integer  "version",      default: 1,         null: false
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "periodicity",  default: "monthly"
    t.integer  "grace_period", default: 5
  end

  add_index "plans", ["product_id"], name: "index_plans_on_product_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "connector"
  end

  create_table "subscription_discounts", force: true do |t|
    t.integer  "subscription_id"
    t.integer  "discount_id"
    t.date     "applied_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscription_discounts", ["discount_id"], name: "index_subscription_discounts_on_discount_id"
  add_index "subscription_discounts", ["subscription_id"], name: "index_subscription_discounts_on_subscription_id"

  create_table "subscriptions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
    t.integer  "customer_id"
    t.date     "valid_until"
    t.datetime "unsubscribed_at"
    t.date     "next_payment"
  end

  create_table "tiers", force: true do |t|
    t.string   "name"
    t.integer  "max_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_per_unit_cents",    default: 0,     null: false
    t.string   "price_per_unit_currency", default: "USD", null: false
    t.string   "type"
    t.integer  "plan_id"
  end

  create_table "voucher_items", force: true do |t|
    t.integer  "voucher_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_pesos",    default: 0,     null: false
    t.string   "amount_currency", default: "CLP", null: false
  end

  add_index "voucher_items", ["voucher_id"], name: "index_voucher_items_on_voucher_id"

  create_table "vouchers", force: true do |t|
    t.integer  "subscription_id"
    t.date     "due_date"
    t.date     "fulfilled"
    t.string   "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vouchers", ["subscription_id"], name: "index_vouchers_on_subscription_id"

end
