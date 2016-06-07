require 'sendgrid-ruby'
require 'email_template'

module SendGrid
  def send_email

    # Create a new SendGrid client
    client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

    # Create a new Mail object and send:
    mail = SendGrid::Mail.new do |m|
      # m.to = 'bplindgren91@gmail.com'
      m.to = 'lisa.dannewitz@gmail.com'
      m.from = 'dbcfsplum-facilitator@gmail.com'
      m.subject = 'Kind of working template?'
      m.html = $TEMPLATE
    end

    res = client.send(mail)
    puts res.code
    puts res.body
  end
end
