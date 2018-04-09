# -*- coding: utf-8 -*-

#require 'active_support'
#require 'active_support/core_ext'

require 'action_mailer'
require 'letter_opener'

AppRoute ||= Pathname.new(File.expand_path(File.dirname(__FILE__)))

def setup_mailer
  ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, location: AppRoute.join('tmp/letter_opener').to_s
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
  AppEnv = ENV['APP_ENV'].presence || 'development'
  setup_mailer
  send_mail
end
