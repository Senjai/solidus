class AddReportsRole < ActiveRecord::Migration
  def up
    Spree::Role.where(name: "report_display").first_or_create!
  end

  def down
    Spree::Role.where(name: "report_display").destroy_all
  end
end
