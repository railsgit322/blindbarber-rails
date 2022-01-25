# frozen_string_literal: true

require 'sendgrid-ruby'

module Mailers
  class ForgotPassword
    include SendGrid

    def initialize(user, link)
      @user = user
      @link = link
      @template_id = 'd-960edd63fe55453aa5056a4b7241144d'
    end

    def call
      mail = Mail.new
      mail.from = Email.new(email: 'no-reply@youbet.io')

      personalization = Personalization.new
      personalization.add_to(Email.new(email: user.email))

      personalization.add_dynamic_template_data(
        'reset_password_link' => link
      )

      mail.add_personalization(personalization)
      mail.template_id = template_id

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      sg.client.mail._('send').post(request_body: mail.to_json)
    end

    private

    attr_reader :user, :link, :template_id
  end
end
