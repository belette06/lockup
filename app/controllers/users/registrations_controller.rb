# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @token = params[:invite_token] if @token.nil? # <-- pulls the value from the url query string
    super
  end

  # POST /resource
  def create
    @token = params[:user][:invite_token]
    if !@token.nil?

      org = Invite.find_by_token(@token) # find the invite with params token
      puts 'ok org'
      @newuser = User.new
      @newuser.email = params[:user][:email]
      @newuser.password = params[:user][:password]
      @newuser.password_confirmation = params[:user][:password_confirmation]
      puts 'ok user build'
      if @newuser.email == org.email
        puts 'oui identiqueeeeeeeeeeeeeeeeeeee'
        @newuser.save
        Appointment.find(org.appointment_id).tenant_id = @newuser.id
        @newuser.invitations_at.push(org) # add this user to the new appointment as a member
        redirect_to invite_url(org)
      else
        flash[:alert] = 'Your email is not identical to invite'
        redirect_to request.referrer
        end
    else
      super
    end
  end

  # GET /resource/edit
  def edit
    @proprietor = current_user.proprietor
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #  super(resource)
  # end
end
