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

ActiveRecord::Schema[7.0].define(version: 2022_05_26_182327) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "delivery_times", force: :cascade do |t|
    t.decimal "initial_distance"
    t.decimal "final_distance"
    t.integer "weekdays"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_delivery_times_on_shipping_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "origin_address"
    t.string "id_code"
    t.decimal "product_length"
    t.decimal "product_height"
    t.decimal "product_width"
    t.decimal "product_weight"
    t.string "destination_address"
    t.integer "status", default: 0
    t.integer "shipping_company_id"
    t.integer "vehicle_id"
    t.integer "route_update_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_update_id"], name: "index_orders_on_route_update_id"
    t.index ["shipping_company_id"], name: "index_orders_on_shipping_company_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "route_updates", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "current_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "email_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shipping_company_id"], name: "index_users_on_shipping_company_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "id_plate"
    t.string "make"
    t.string "model"
    t.string "year"
    t.integer "load_capacity"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_vehicles_on_shipping_company_id"
  end

  create_table "volume_prices", force: :cascade do |t|
    t.decimal "initial_volume"
    t.decimal "final_volume"
    t.decimal "price"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_volume_prices_on_shipping_company_id"
  end

  create_table "weight_prices", force: :cascade do |t|
    t.decimal "initial_weight"
    t.decimal "final_weight"
    t.decimal "price"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_weight_prices_on_shipping_company_id"
  end

  add_foreign_key "delivery_times", "shipping_companies"
  add_foreign_key "orders", "route_updates"
  add_foreign_key "orders", "shipping_companies"
  add_foreign_key "orders", "vehicles"
  add_foreign_key "users", "shipping_companies"
  add_foreign_key "vehicles", "shipping_companies"
  add_foreign_key "volume_prices", "shipping_companies"
  add_foreign_key "weight_prices", "shipping_companies"
end
