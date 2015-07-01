class AddProductManagementRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "product_management").first_or_create!
    Spree::Role.where(name: "product_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ["product_management", "product_display"]).destroy_all
  end
end
