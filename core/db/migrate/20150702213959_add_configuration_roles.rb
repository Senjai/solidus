class AddConfigurationRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "configuration_management").first_or_create!
    Spree::Role.where(name: "configuration_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ["configuration_display", "configuration_management"]).destroy_all
  end
end
