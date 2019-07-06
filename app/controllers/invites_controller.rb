class InvitesController < ApplicationController
  before_action :set_invites, only: %i[ show edit update destroy]

  def index
    @invites = Invite.all
  end

  def show;

  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(params_invite) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save
      InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our invites_mailer to deliver the email
    else
      # oh no, creating an new invitation failed
    end
  end

  def edit; end

  def update
    if @invite.update
      redirect_to root_path
    end
  end

  def destroy
    if @invite.destroy
      redirect_to root_path
    end
  end

  private

  def set_invites
    @invite =  @invite = Invite.find(params[:invite_id])
  end

  def params_invite
    params.require(:invite).permit(:email, :token, :appointment_id, :recipient_id, :sender_id)
  end

end
