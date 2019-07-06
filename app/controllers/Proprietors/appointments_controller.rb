# frozen_string_literal: true
require 'pry'

module Proprietors
class AppointmentsController < HomesController
  before_action :set_appointment, only: %i[show edit update destroy]
    before_action :authenticate_user!


    def index
      @home = Home.find(params[:home_id])
      @appointments = Appointment.where(home_id: params[:home_id])
    end

    def show
    end

    def new
      @invite = Invite.new
      @appointment = Appointment.new
      @home = @proprietor.homes
    end

    def edit
      @home = Home.find(params[:home_id])
    end

    def create
      @invite = Invite.new
      @home = @proprietor.homes
      @appointment = Appointment.new(appointment_params)

      @invite.email = params[:appointment][:invite][:email]
      @invite.sender_id = current_user.id

      @appointment.kind = "appointment"
      @user = User.find_by(email: @email)
      @appointment.tenant = @user if @user == @email
      @appointment.home_id = params[:appointment][:home]
puts "1===================================="
      if @appointment.save
        @invite.appointment_id = current_user.id
        puts "2===================================="


        if @invite.save

          #if the user already exists
          if @invite.recipient != nil

            #send a notification email
            InvitesMailer.existing_user_invite(@invite).deliver

            #Add the user to the user group
            @invite.recipient.user_groups.push(@invite.user_group)

          else
            InvitesMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
          end
        else
          # oh no, creating an new invitation failed
        end
           # mailer_invitation_appointment(@email, @home)
        flash[:notice] = "#{@email} ne fait pas partie du site. Nous venons de lancer une invitation" if !@email.nil?
        redirect_to proprietors_home_appointments_path
      end
    end

    def update
      @home = Home.find(params[:home_id])
        if @appointment.update(appointment_params)
          redirect_to proprietors_home_appointments_path
        else
          render :edit
      end
    end

    def destroy
      @appointment.destroy
      redirect_to proprietors_home_appointments_path
    end

    private

    ##def params_appointment
    ##  params.require(:appointment).permit(:homes, :tenant, :kind, :weekly_recurring, :ends_at, :starts_at)
    ##end

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:kind, :starts_at, :ends_at, :weekly_recurring, :home_id)
    end

    def mailer_invitation_appointment(email, tenant)
      UserMailer. invitation_home_mail(email, tenant).deliver_now
    end
  end

  end