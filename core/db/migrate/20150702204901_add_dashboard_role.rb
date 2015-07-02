class AddDashboardRole < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "dashboard_display").first_or_create!
  end

  def down
    Spree::Role.where(name: "dashboard_display").destroy_all
  end
end
