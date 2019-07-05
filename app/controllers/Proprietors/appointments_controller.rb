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
      @appointment = Appointment.new
      @home = @proprietor.homes
    end

    def edit
      @home = Home.find(params[:home_id])
    end

    def create
      @home = @proprietor.homes
      @appointment = Appointment.new(appointment_params)
      @email = params[:appointment][:email]
      @appointment.kind = "appointment"
      @user = User.find_by(email: @email)
      @appointment.tenant = @user if @user == @email
      @appointment.home_id = params[:appointment][:home]

      if @appointment.save
        mailer_invitation_appointment(@email, @home)
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