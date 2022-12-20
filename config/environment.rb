# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  user_name: ENV['GMAIL'],
  password: ENV['GOOGLE_APP_PASSWORD'],
  # domain: 'admin.example.com',
  address: 'smtp.gmail.com',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

# ActionMailer::Base.smtp_settings = {
#   user_name: ENV['SENDGRID_USER_NAME'],
#   password: ENV['SENDGRID_PASSWORD'],
#   domain: 'admin.example.com',
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   authentication: :plain,
#   enable_starttls_auto: true
# }