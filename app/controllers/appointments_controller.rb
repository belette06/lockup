# frozen_string_literal: true

require 'pry'
class AppointmentsController < ApplicationController
  before_action :set_home, only: %i[new create edit update destroy index]

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
    @kind = "appointment"
    @tenant = User.find_by(email: @email)
    email = @email
binding.pry
      if @tenant.nil?
        @appointment.save
        mailer_invitation_appointment(@email, @home)
        flash[:notice] = "#{email} ne fait pas partie du site. Nous venons de lancer une invitation"
        redirect_to root_path
      else
        mailer_invitation_appointment(@email, @home)
        flash[:notice] = " #{email} deja inscrits sur le site invitation  envoyer "
        redirect_to  root_path
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
    @home = Home.find(params[:home_id])
  end

  def mailer_invitation_appointment(email, tenant)
    UserMailer. invitation_home_mail(email, tenant).deliver_now
  end
end
