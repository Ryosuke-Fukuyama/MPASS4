# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def calling_soon
    @email = 'test-mail@mail.com'
    @hospital_name = 'テストサンプル病院'
    NotificationMailer.with(to: @email, hospital_name: @hospital_name).calling_soon
  end

  def bill_check
    @email = 'test-mail@mail.com'
    hospital = Hash["name", 'テストサンプル病院']
    @health_interview = Hash["price", 100, "hospital", hospital]
    @health_interview = JSON.parse(@health_interview.to_json, object_class: OpenStruct)
    NotificationMailer.with(to: @email, health_interview: @health_interview).bill_check
  end
end
