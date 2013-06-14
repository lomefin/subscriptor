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

ActiveRecord::Schema.define(version: 20130614023703) do

  create_table "discounts", force: true do |t|
    t.integer  "applied_to"
    t.string   "unit"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_cents",    default: 0,     null: false
    t.string   "value_currency", default: "USD", null: false
  end

  add_index "discounts", ["plan_id"], name: "index_discounts_on_plan_id"

  create_table "item_charges", force: true do |t|
    t.string   "description"
    t.date     "due"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost_cents",    default: 0,     null: false
    t.string   "cost_currency", default: "USD", null: false
  end

  add_index "item_charges", ["plan_id"], name: "index_item_charges_on_plan_id"

  create_table "plans", force: true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["product_id"], name: "index_plans_on_product_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiers", force: true do |t|
    t.integer  "charge_id"
    t.string   "name"
    t.integer  "max_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_per_unit_cents",    default: 0,     null: false
    t.string   "price_per_unit_currency", default: "USD", null: false
  end

  add_index "tiers", ["charge_id"], name: "index_tiers_on_charge_id"

end
