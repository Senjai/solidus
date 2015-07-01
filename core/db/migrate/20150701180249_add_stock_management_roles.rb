class AddStockManagementRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "stock_management").first_or_create!
    Spree::Role.where(name: "stock_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ["stock_management", "stock_display"]).destroy_all
  end
end
