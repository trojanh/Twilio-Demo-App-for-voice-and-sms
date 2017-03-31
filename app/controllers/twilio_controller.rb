require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
    debugger
    render_twiml response
  end

  def sms
    # put your own credentials here
    account_sid = 'AC65724ee66382ebf8334cab4f8ac0e3d4'
    auth_token = '850b3f5f5a95cc31b2bc765a1c6a3d3d'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    response = @client.account.messages.create(
      from: '+18172033115',
      to: '+919768213294',
      body: 'Robot invasion! Reply back with any sightings. Your trial account has $14.50 remaining'
    )
    debugger
    render_twiml reponse
  end

end
