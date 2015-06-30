class CreateOrderRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "order_management").first_or_create!
    Spree::Role.where(name: "order_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ["order_display", "order_management"]).destroy_all
  end
end
