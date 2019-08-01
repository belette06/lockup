# frozen_string_literal: true

class InvitePolicy < ApplicationPolicy
  def index?
    # binding.pry
    r1 = Invite.select(:sender_id)
    r2 = Invite.select(:recipient_id)

    return true if user == r1 || r2

    # record.where('recipient_id' == user.id)
    # user.sent_invites === record.sender_id
  end

  def show?
    user.id === record.recipient_id
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
