# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_23_174152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "canada_sites", id: false, force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.string "province", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["code"], name: "index_canada_sites_on_code", unique: true
    t.index ["latitude", "longitude"], name: "index_canada_sites_on_latitude_and_longitude"
  end

end
