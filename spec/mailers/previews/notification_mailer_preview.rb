# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def calling_soon
    @email = 'testmail@mail.com'
    @hospital_name = 'テストサンプル病院'
    NotificationMailer.with(to: @email, hospital_name: @hospital_name).calling_soon
  end
end
