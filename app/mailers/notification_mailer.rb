class NotificationMailer < ApplicationMailer
  def calling_soon
    @hospital_name = params[:hospital_name]

    mail to: params[:to], subject: t('mailer.subject.calling_soon')
  end
end
