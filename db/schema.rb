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

ActiveRecord::Schema[7.1].define(version: 2025_06_28_020619) do
  create_table "clientes", force: :cascade do |t|
    t.string "nombre"
    t.string "correo"
    t.string "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detalle_facturas", force: :cascade do |t|
    t.integer "factura_id", null: false
    t.integer "producto_id", null: false
    t.integer "cantidad"
    t.decimal "precio_unitario"
    t.integer "tasa_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factura_id"], name: "index_detalle_facturas_on_factura_id"
    t.index ["producto_id"], name: "index_detalle_facturas_on_producto_id"
    t.index ["tasa_id"], name: "index_detalle_facturas_on_tasa_id"
  end

  create_table "facturas", force: :cascade do |t|
    t.integer "cliente_id", null: false
    t.integer "numero"
    t.decimal "subtotal"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_facturas_on_cliente_id"
  end

  create_table "movimientos", force: :cascade do |t|
    t.integer "producto_id"
    t.integer "cantidad"
    t.string "tipo"
    t.string "nota"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "producto_nombre"
    t.index ["producto_id"], name: "index_movimientos_on_producto_id"
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre"
    t.decimal "precio"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasas", force: :cascade do |t|
    t.string "nombre"
    t.decimal "porcentaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "detalle_facturas", "facturas"
  add_foreign_key "detalle_facturas", "productos"
  add_foreign_key "detalle_facturas", "tasas"
  add_foreign_key "facturas", "clientes"
  add_foreign_key "movimientos", "productos"
end
