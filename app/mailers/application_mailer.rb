class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: 'from@example.com'
  layout 'mailer'
end
