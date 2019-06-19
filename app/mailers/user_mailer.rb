class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user) #model
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def contact
     mail(to: 'contact@test.fr', subject:'sujet de test')
  end

 ## def invitation_appointment_mail(appointment)
  #  @appointment = appointment
   # @home = @appointment.home
   # @title = @appointment.home.title
   # mail(to: @appointment.tenant.email, subject: "Invitation a rejoindre un rendez vous ")
  #end

  def  invitation_home_mail(email, home) #controller
    @home = home
    @email = email
    mail(to: @email, subject: "Invitation à devenir membre ")
  end


end
