class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all

    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @appointment }
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @appointment.tenant = Tenant.new

  end


  def edit
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new
    @appointment.tenant = Tenant.new

    @appointment.tenant_id = @appointment.tenant.id
    @appointment.tenant.save
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Product was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:tenant])
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


  def appointment_params
  params.require(:appointment).permit(:home_id).merge(tenant_id: tenant.id)
end


end


