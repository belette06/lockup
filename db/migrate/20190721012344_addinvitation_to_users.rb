# frozen_string_literal: true

class AddinvitationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invitations_at, :string
    add_column :users, :sent_invites, :string
  end
end
