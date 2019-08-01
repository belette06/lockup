# frozen_string_literal: true

class AppointmentPolicy < ApplicationPolicy
  def index?
    false
  end

  def create?
    user.proprietor.present?
  end

  def update?
    return true if user.proprietor.present? # && user.admin?

    binding.pry
    user.proprietor.present? && user.proprietor == post.user.proprietor
  end

  def destroy?
    user.proprietor.present? # && user.admin?
  end

  private

  def post
    record
  end
end
