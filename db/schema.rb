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

ActiveRecord::Schema.define(version: 20181202195634) do

  create_table "abilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username",               default: "",    null: false
    t.boolean  "anonymous",              default: false
    t.integer  "group_role_id"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["group_role_id"], name: "index_admin_users_on_group_role_id"
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "credits", force: :cascade do |t|
    t.float    "value",       default: 0.0
    t.integer  "priority",    default: 0
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "custom_name", default: ""
    t.string   "name",        default: ""
  end

  create_table "group_roles", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "logo_static_values", force: :cascade do |t|
    t.string   "name",        default: ""
    t.string   "logo_type",   default: ""
    t.integer  "amount",      default: 0
    t.float    "value",       default: 0.0
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "custom_name", default: ""
  end

  create_table "orders", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "tel"
    t.string   "email"
    t.string   "note"
    t.boolean  "active",                    default: true,         null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "stuff_img_file_name"
    t.string   "stuff_img_content_type"
    t.integer  "stuff_img_file_size"
    t.datetime "stuff_img_updated_at"
    t.string   "stuff_picker",              default: ""
    t.string   "stuff_price",               default: ""
    t.string   "base_price",                default: ""
    t.string   "company_name",              default: ""
    t.string   "company_branch",            default: ""
    t.string   "tax_identification_number", default: ""
    t.string   "estimate_cost",             default: ""
    t.string   "status",                    default: "no contact"
    t.string   "option_price_details",      default: ""
    t.string   "price_amount_report",       default: ""
    t.integer  "admin_user_id"
    t.float    "total_price",               default: 0.0
    t.string   "fax",                       default: ""
    t.integer  "user_id"
  end

  add_index "orders", ["admin_user_id"], name: "index_orders_on_admin_user_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "pledges", force: :cascade do |t|
    t.float    "value",       default: 0.0
    t.integer  "priority",    default: 0
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "custom_name", default: ""
    t.string   "name",        default: ""
  end

  create_table "quotation_prices", force: :cascade do |t|
    t.integer  "amount",        default: 0
    t.float    "price",         default: 0.0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "quotations_id"
    t.integer  "quotation_id"
    t.string   "name",          default: ""
  end

  add_index "quotation_prices", ["quotation_id"], name: "index_quotation_prices_on_quotation_id"
  add_index "quotation_prices", ["quotations_id"], name: "index_quotation_prices_on_quotations_id"

  create_table "quotations", force: :cascade do |t|
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name",                default: ""
    t.string   "last_name",                 default: ""
    t.string   "address",                   default: ""
    t.string   "tel",                       default: ""
    t.string   "email",                     default: ""
    t.string   "note",                      default: ""
    t.boolean  "active",                    default: true
    t.string   "stuff_img_file_name"
    t.string   "stuff_img_content_type"
    t.integer  "stuff_img_file_size"
    t.datetime "stuff_img_updated_at"
    t.string   "stuff_picker",              default: ""
    t.string   "stuff_price",               default: ""
    t.string   "base_price",                default: ""
    t.string   "company_name",              default: ""
    t.string   "company_branch",            default: ""
    t.string   "tax_identification_number", default: ""
    t.string   "estimate_cost",             default: ""
    t.string   "status",                    default: ""
    t.string   "option_price_details",      default: ""
    t.string   "price_amount_report",       default: ""
    t.integer  "admin_user_id"
    t.float    "commission",                default: 0.0
    t.boolean  "complete",                  default: false
    t.float    "total_price",               default: 0.0
    t.integer  "credit_id"
    t.integer  "pledge_id"
    t.float    "final_price",               default: 0.0
    t.float    "current_credit",            default: 1.0
    t.float    "current_pledge",            default: 1.0
    t.string   "fax",                       default: ""
    t.integer  "user_id"
  end

  add_index "quotations", ["admin_user_id"], name: "index_quotations_on_admin_user_id"
  add_index "quotations", ["credit_id"], name: "index_quotations_on_credit_id"
  add_index "quotations", ["pledge_id"], name: "index_quotations_on_pledge_id"
  add_index "quotations", ["user_id"], name: "index_quotations_on_user_id"

  create_table "setting_roles", force: :cascade do |t|
    t.string   "permission",    default: ""
    t.string   "access",        default: ""
    t.string   "model_access",  default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "group_role_id"
    t.integer  "admin_user_id"
  end

  add_index "setting_roles", ["admin_user_id"], name: "index_setting_roles_on_admin_user_id"
  add_index "setting_roles", ["group_role_id"], name: "index_setting_roles_on_group_role_id"

  create_table "static_values", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.boolean  "active",             default: true, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "stuff_colors", force: :cascade do |t|
    t.string   "name"
    t.string   "color_code"
    t.boolean  "active",        default: true, null: false
    t.integer  "priority",      default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "stuff_type_id"
    t.integer  "color_layer",   default: 0
    t.integer  "stuff_id"
    t.float    "color_price",   default: 1.0
  end

  add_index "stuff_colors", ["stuff_id"], name: "index_stuff_colors_on_stuff_id"
  add_index "stuff_colors", ["stuff_type_id"], name: "index_stuff_colors_on_stuff_type_id"

  create_table "stuff_exist_sizes", force: :cascade do |t|
    t.integer  "priority",        default: 0
    t.float    "price",           default: 0.0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "stuff_exists_id"
    t.integer  "stuff_exist_id"
    t.string   "name",            default: ""
    t.string   "sex",             default: ""
  end

  add_index "stuff_exist_sizes", ["stuff_exist_id"], name: "index_stuff_exist_sizes_on_stuff_exist_id"
  add_index "stuff_exist_sizes", ["stuff_exists_id"], name: "index_stuff_exist_sizes_on_stuff_exists_id"

  create_table "stuff_exists", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "size"
    t.boolean  "active",                       default: true, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "stuff_exist_img_file_name"
    t.string   "stuff_exist_img_content_type"
    t.integer  "stuff_exist_img_file_size"
    t.datetime "stuff_exist_img_updated_at"
  end

  create_table "stuff_logos", force: :cascade do |t|
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "stuff_logo_img_file_name"
    t.string   "stuff_logo_img_content_type"
    t.integer  "stuff_logo_img_file_size"
    t.datetime "stuff_logo_img_updated_at"
    t.string   "color_number",                default: ""
    t.string   "logo_type",                   default: ""
    t.string   "logo_width",                  default: ""
    t.string   "logo_height",                 default: ""
    t.float    "max_height",                  default: 0.0
    t.float    "max_width",                   default: 0.0
  end

  create_table "stuff_orders", force: :cascade do |t|
    t.integer  "stuff_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stuff_orders", ["order_id"], name: "index_stuff_orders_on_order_id"
  add_index "stuff_orders", ["stuff_id"], name: "index_stuff_orders_on_stuff_id"

  create_table "stuff_profits", force: :cascade do |t|
    t.string   "name",       default: ""
    t.integer  "amount"
    t.float    "profit"
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "stuff_sizes", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.boolean  "active",           default: true,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "priority",         default: 0
    t.integer  "stuff_type_id"
    t.integer  "stuff_id"
    t.float    "base_price",       default: 1.0
    t.string   "sex",              default: "male"
    t.string   "breast",           default: ""
    t.string   "long",             default: ""
    t.float    "add_option_price", default: 0.0
    t.string   "custom_name",      default: "MALE"
    t.float    "pattern_price",    default: 0.0
  end

  add_index "stuff_sizes", ["stuff_id"], name: "index_stuff_sizes_on_stuff_id"
  add_index "stuff_sizes", ["stuff_type_id"], name: "index_stuff_sizes_on_stuff_type_id"

  create_table "stuff_textures", force: :cascade do |t|
    t.string   "name",                           default: "",   null: false
    t.integer  "priority",                       default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "stuff_texture_img_file_name"
    t.string   "stuff_texture_img_content_type"
    t.integer  "stuff_texture_img_file_size"
    t.datetime "stuff_texture_img_updated_at"
    t.boolean  "active",                         default: true
    t.integer  "stuffs_id"
    t.integer  "stuff_id"
    t.float    "price",                          default: 1.0
    t.float    "status_flexible",                default: 5.0
    t.float    "status_thick",                   default: 5.0
    t.float    "status_velvety",                 default: 5.0
    t.float    "consumption",                    default: 0.0
    t.string   "desc",                           default: ""
  end

  add_index "stuff_textures", ["stuff_id"], name: "index_stuff_textures_on_stuff_id"
  add_index "stuff_textures", ["stuffs_id"], name: "index_stuff_textures_on_stuffs_id"

  create_table "stuff_types", force: :cascade do |t|
    t.string   "name",                        default: "",   null: false
    t.string   "desc",                        default: ""
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "stuff_type_img_file_name"
    t.string   "stuff_type_img_content_type"
    t.integer  "stuff_type_img_file_size"
    t.datetime "stuff_type_img_updated_at"
    t.integer  "order",                       default: 0
    t.boolean  "active",                      default: true
    t.integer  "priority",                    default: 0
    t.string   "custom_name",                 default: ""
    t.boolean  "delete_stuff_button",         default: true
  end

  create_table "stuffs", force: :cascade do |t|
    t.string   "name",                                 default: "",   null: false
    t.string   "desc",                                 default: ""
    t.float    "price"
    t.boolean  "active",                               default: true, null: false
    t.integer  "stuff_type_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "stuff_img_file_name"
    t.string   "stuff_img_content_type"
    t.integer  "stuff_img_file_size"
    t.datetime "stuff_img_updated_at"
    t.string   "stuff_product_img_file_name"
    t.string   "stuff_product_img_content_type"
    t.integer  "stuff_product_img_file_size"
    t.datetime "stuff_product_img_updated_at"
    t.string   "stuff_product_img_two_file_name"
    t.string   "stuff_product_img_two_content_type"
    t.integer  "stuff_product_img_two_file_size"
    t.datetime "stuff_product_img_two_updated_at"
    t.string   "belong_to_type",                       default: ""
    t.string   "additional_price",                     default: ""
    t.float    "color_ratio_0",                        default: 1.0
    t.float    "color_ratio_1",                        default: 1.0
    t.integer  "priority",                             default: 0
    t.string   "stuff_product_img_three_file_name"
    t.string   "stuff_product_img_three_content_type"
    t.integer  "stuff_product_img_three_file_size"
    t.datetime "stuff_product_img_three_updated_at"
    t.float    "color_ratio_2",                        default: 1.0
    t.boolean  "delete_stuff_button",                  default: true
  end

  add_index "stuffs", ["stuff_type_id"], name: "index_stuffs_on_stuff_type_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address"
    t.string   "phone"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
