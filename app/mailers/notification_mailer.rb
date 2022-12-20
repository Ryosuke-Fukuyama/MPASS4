class NotificationMailer < ApplicationMailer
  def calling_soon
    @hospital_name = params[:hospital_name]

    mail to: params[:to], subject: t('mailer.subject.calling_soon')
  end

  def bill_check
    @health_interview = params[:health_interview]

    mail to: params[:to], subject: t('mailer.subject.bill_check')
  end
end
