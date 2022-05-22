# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_21_164351) do
  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "identification"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "price_unit"
    t.integer "total"
    t.text "observations"
    t.integer "product_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.text "observations"
    t.integer "total_value"
    t.integer "tax"
    t.integer "tip"
    t.integer "guests"
    t.boolean "active"
    t.integer "user_id", null: false
    t.integer "customer_id"
    t.integer "table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["table_id"], name: "index_orders_on_table_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "stock"
    t.boolean "active"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "pasword_hash"
    t.string "password_salt"
    t.integer "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "orders"
  add_foreign_key "items", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "tables"
  add_foreign_key "orders", "users"
end
