# -*- coding: utf-8 -*-

require 'action_mailer'
require 'letter_opener'

def setup_mailer
  ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, location: 'tmp/letter_opener'
  ActionMailer::Base.delivery_method = :letter_opener
end

def send_mail
  NewsMailer.day_mail.deliver_now
end

class NewsMailer < ActionMailer::Base
  def day_mail
    mail(
      to: 'test@example.com',
      from: 'test@example.com',
      subject: 'mailtest',
    ) do |format|
      format.text { render text: 'Hello' }
    end
  end
end

if $0 === __FILE__
  setup_mailer
  send_mail
end
