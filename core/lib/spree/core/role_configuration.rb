require 'singleton'

module Spree
  # A class responsible for associating {Spree::Role} with a list of permission sets.
  #
  # @see Spree::PermissionSets
  #
  # @example Adding order, product, and user display to customer service users.
  #   Spree::RoleConfiguration.configure do |config|
  #     config.register_role :customer_service, [
  #       Spree::PermissionSets::OrderDisplay,
  #       Spree::PermissionSets::UserDisplay,
  #       Spree::PermissionSets::ProductDisplay
  #     ]
  #   end
  class RoleConfiguration
    # An internal structure for the association between a role and a
    # set of permissions.
    Role = Struct.new(:name, :permission_sets)

    include Singleton
    attr_accessor :roles

    # Yields the instance of the singleton, used for configuration
    # @yield_param instance [Spree::RoleConfiguration]
    def self.configure
      yield(instance)
    end

    # Given an ability, and a user, determine what permissions sets can be activated
    # on the ability, then activate them.
    #
    # This performs can/cannot declarations on the ability, and can modify it's internal permissions
    #
    # @param ability [CanCan::Ability] the ability to invoke declarations on
    # @param user [#spree_roles] the user that holds the spree_roles association.
    def activate_permissions! ability, user
      spree_roles = user.spree_roles.pluck(:name)
      applicable_permissions = Set.new

      roles.each do |role|
        if spree_roles.include?(role[:name])
          applicable_permissions |= role.permission_sets
        end
      end

      applicable_permissions.each do |permission_set|
        permission_set.new(ability).activate!
      end
    end

    # Not public due to the fact this class is a Singleton
    # @!visibility private
    def initialize
      @roles = []
    end

    # Register permission sets for a {Spree::Role} that has the name of role_name
    # @param role_name [Symbol, String] The name of the role to associate permissions with
    # @param permission_sets [Array<Spree::PermissionSet>, Set<Spree::PermissionSet>]
    #   A list of permission sets to activate if the user has the role indicated by role_name
    def register_role role_name, permission_sets
      sets = normalize_sets(permission_sets)
      name = role_name.to_s

      if role = find_role(name)
        role.permission_sets|= sets
      else
        @roles << Role.new(name, sets)
      end
    end

    private

    def find_role name
      @roles.detect { |role| role.name == name }
    end

    def normalize_sets sets
      return sets if sets.is_a?(Set)
      Set.new(Array.wrap(sets))
    end
  end
end
