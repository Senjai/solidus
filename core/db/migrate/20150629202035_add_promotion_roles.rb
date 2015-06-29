class AddPromotionRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "promotion_management").first_or_create!
    Spree::Role.where(name: "promotion_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ["promotion_display", "promotion_management"]).destroy_all
  end
end
