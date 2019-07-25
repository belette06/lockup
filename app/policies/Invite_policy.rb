
class InvitePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    binding.pry
  end

  def create?
    binding.pry
      user.proprietor.present?
  end

  def update?
    return true if user.proprietor.present? && user.admin?
binding.pry
    user.proprietor.present? && user == post.user
  end

  def destroy?
    user.present? && user.admin?
  end

  private

  def post
    record
  end
end