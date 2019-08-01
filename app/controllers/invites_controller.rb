# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invites, only: %i[show edit update destroy]
  before_action :find_proprietor, only: %i[show index]

  def index
    # @invites = Invite.all if current_user.admin
    # @invitations = Invite.where(sender_id: current_user.id)
    # @invitables = Invite.where(recipient_id: current_user.id)
    @invitations = current_user.sent_invites
    @invitables = current_user.invitations_at

    authorize @invitations
    authorize @invitables
  end

  def show
    authorize @invite
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    if @invite.save
      if !@invite.recipient.nil? # if the user already exists
        InviteMailer.existing_user_invite(@invite).deliver # send a notification email
        @invite.recipient.appointments.push(@invite.appointment) # Add the user to the user group
      else
        InviteMailer.new_user_invite(@invite, new_user_registration_path(invite_token: @invite.token)).deliver
      end
    else
      # oh no, creating an new invitation failed
    end
  end

  def edit; end

  def update
    redirect_to root_path if @invite.update
  end

  def destroy
    redirect_to root_path if @invite.destroy
  end

  private

  def set_invites
    @invite = Invite.find(params[:id])
  end

  def find_proprietor
    @proprietor = current_user.proprietor
  end

  def params_invite
    params.require(:invite).permit(:email, :token, :appointment_id, :recipient_id, :sender_id)
  end
end
