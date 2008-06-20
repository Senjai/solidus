class Property < ActiveRecord::Base
  has_many :property_values
  has_and_belongs_to_many :prototypes

  validates_presence_of :name, :presentation

  def self.find_all_by_prototype(prototype)
    id = prototype
    if prototype.class == Prototype
      id = prototype.id
    end

    find(:all, :conditions => [ 'prototype_id = ?', id ],
         :joins => 'left join properties_prototypes on property_id = properties.id')
  end
end
