# frozen_string_literal: true

require 'pry'
class AppointmentsController < ApplicationController
  before_action :set_home, only: %i[new create edit update destroy index]

  def index
    @appointments = @home.appointment

    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @appointment }
    end
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
    @appointment = @home.build_appointment
    #@tenant = Tenant.new(params[:tenant])
    #@tenant.name = params[:appointment][:tenant][:name]
    #
    @email = params[:appointment][:email]
    @tenant = User.find_by(email: @email)
    @bookable = Appointment.find_by(tenant: @tenant, home: @home)
    tenant = @tenant
    email = @email

    if !@tenant.nil? && @bookable.nil? && @home.nil?
      @appointment = Appointment.create(
                                          home: @home,
                                          tenant: @tenant,
                                          kind: kind,
                                          weekly_recurring: weekly_recurring,
                                          ends_at: ends_at,
                                          starts_at: starts_at,
                                        )
      @appointment.save
      flash[:notice] = "#{tenant.name} Utilisateur est invite"
    elsif !@tenant.nil? && !@bookable.nil?
      flash[:notice] = "#{tenant.name} Utilisateur deja invite"
    else
      mailer_invitation_appointment(@email, @home)
      flash[:notice] = "#{email} ne fait pas partie du site. Nous venons de lancer une invitation"
    end
    #redirect_to tenant_home_path(@home)
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

  def set_home
    @home = Home.find(params[:home_id])
  end

  def tenant_params
    params.require(:tenant).permit(:name)
  end

  def mailer_invitation_appointment(email, tenant)
    UserMailer. invitation_home_mail(email, tenant).deliver_now
  end
end
