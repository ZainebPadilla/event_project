class AttendanceMailer < ApplicationMailer
  default from: 'no-reply@eventproject.fr'

  def new_participation_email(attendance)
    @attendance = attendance
    @event = @attendance.event
    @admin = @event.admin
    @user = @attendance.user

    mail(to: @admin.email, subject: 'Nouvelle participation à votre événement')
  end
end
