class AddUserManagementRoles < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "user_management").first_or_create!
    Spree::Role.where(name: "user_display").first_or_create!
  end

  def down
    Spree::Role.where(name: ['user_display', 'user_management']).destroy_all
  end
end
