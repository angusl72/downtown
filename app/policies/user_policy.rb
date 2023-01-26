class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def edit_profile_photo?
    user == record
  end

  def update_profile_photo?
    true
  end

  def show?
    true
  end
end
