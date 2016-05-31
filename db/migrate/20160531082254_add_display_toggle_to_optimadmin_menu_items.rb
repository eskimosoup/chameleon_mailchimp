class AddDisplayToggleToOptimadminMenuItems < ActiveRecord::Migration
  def change
    add_column :optimadmin_menu_items, :display, :boolean, null: false, default: true
  end
end
