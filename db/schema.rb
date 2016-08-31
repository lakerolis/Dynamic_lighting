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

ActiveRecord::Schema.define(version: 20160831114234) do

  create_table "aactions", force: :cascade do |t|
    t.text     "name"
    t.text     "config"
    t.integer  "actor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rule_id"
  end

  add_index "aactions", ["actor_id"], name: "index_aactions_on_actor_id"
  add_index "aactions", ["rule_id"], name: "index_aactions_on_rule_id"

  create_table "actions", force: :cascade do |t|
    t.text     "name"
    t.text     "config"
    t.integer  "actor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "actions", ["actor_id"], name: "index_actions_on_actor_id"

  create_table "actors", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "defaultConfig"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "operator"
    t.text     "operator_value"
    t.integer  "sensor_id"
    t.integer  "rule_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "conditions", ["rule_id"], name: "index_conditions_on_rule_id"
  add_index "conditions", ["sensor_id"], name: "index_conditions_on_sensor_id"

  create_table "rules", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "state"
    t.text     "conditionType"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sensor_inputs", force: :cascade do |t|
    t.text     "sensor_id"
    t.text     "sensorvalue"
    t.text     "triggered"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "value"
  end

end
