# frozen_string_literal: true

require 'pry'
class Homes::AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_home, only: %i[news create edit update destroy]

  def index

    @appointments = @home.appointment

  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = @home.build_appointment
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = @home.build_appointment(params_appointment)
    @email = params[:appointment][:email]
    @appointment.kind = "appointment"
    @user = User.find_by(email: @email)
    @appointment.tenant = @user if @user == @email

      if @appointment.save
          mailer_invitation_appointment(@email, @home)
          flash[:notice] = "#{@email} ne fait pas partie du site. Nous venons de lancer une invitation" if !@email.nil?
        redirect_to root_path
      else
        redirect_to new_home_appointment_path(@home)
        #mailer_invitation_appointment(@email, @home)
        #flash[:notice] = " #{email} deja inscrits sur le site invitation  envoyer "
        #redirect_to  root_path
      end
  end


  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update(params[:tenant])
        format.html { redirect_to @appointment, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointment_url }
      format.json { head :no_content }
    end
  end

  private

  def params_appointment
    params.require(:appointment).permit(:home, :tenant, :kind, :weekly_recurring, :ends_at, :starts_at)
  end

  def set_home
    @home = Home.find(params[:id])
  end

  def mailer_invitation_appointment(email, tenant)
    UserMailer. invitation_home_mail(email, tenant).deliver_now
  end
end
