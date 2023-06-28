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

ActiveRecord::Schema[7.0].define(version: 2023_06_28_131135) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "audits", force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.uuid "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "custom_auto_increments", force: :cascade do |t|
    t.string "counter_model_name"
    t.integer "counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counter_model_name"], name: "index_custom_auto_increments_on_counter_model_name"
  end

  create_table "historico_consumos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "imovel_id", null: false
    t.integer "consumo"
    t.integer "leitura"
    t.datetime "data_consumo"
    t.float "valor_consumo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imovel_id"], name: "index_historico_consumos_on_imovel_id"
  end

  create_table "imoveis", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "cep"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "morador_id", null: false
    t.index ["deleted_at"], name: "index_imoveis_on_deleted_at"
    t.index ["morador_id"], name: "index_imoveis_on_morador_id"
  end

  create_table "leituras", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "valor_leitura"
    t.datetime "data_leitura"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "imovel_id", null: false
    t.index ["deleted_at"], name: "index_leituras_on_deleted_at"
    t.index ["imovel_id"], name: "index_leituras_on_imovel_id"
  end

  create_table "moradores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_moradores_on_deleted_at"
  end

  create_table "seed_migration_data_migrations", force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "taxas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "valor_kwh"
    t.float "bandeira"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_taxas_on_deleted_at"
  end

  add_foreign_key "historico_consumos", "imoveis"
  add_foreign_key "imoveis", "moradores"
  add_foreign_key "leituras", "imoveis"
end
