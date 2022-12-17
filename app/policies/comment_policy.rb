class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def new?
      true
    end

    def create?
      new?
    end

    def destroy?
      record.user == user
    end

  end
end
