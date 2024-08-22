class ChildPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(caregiver: user) 
    end
  end

  def index?
    true
  end

  def show?
    user_is_owner?
  end

  def create?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def select?
    user_is_owner?
  end

  def details?
    user_is_owner?
  end

  private

  def user_is_owner?
    record.caregiver_id == user.id 
  end
end
