require 'sendgrid-ruby'

module SendGrid
  def send_email
    # Create a new SendGrid client
    client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

    # Import invoice template
    # template = SendGrid::Template.new('b5ee83e8-341b-4f59-b73c-cd496c514e48')
    # p template

    # recipients = [SendGrid::Recipient.new('lisa.dannewitz@gmail.com')]

    # mail_defaults = {
    #   from: 'dbcfsplum-facilitator@gmail.com',
    #   # html: '<h1>I like email</h1>',
    #   text: '#{Event.first.name}',
    #   subject: 'Email is great'
    # }

    # mailer = SendGrid::TemplateMailer.new(client, template, recipients)

    # res = mailer.mail(mail_defaults)


    # Create a new Mail object and send:
    # 10.times do
        mail = SendGrid::Mail.new do |m|
        # m.to = 'bplindgren91@gmail.com'
        m.to = 'lisa.dannewitz@gmail.com'
        m.from = 'dbcfsplum-facilitator@gmail.com'
        m.subject = 'CSS test/does it interpolate? with x-smt'
        # m.template = template
        # m.smtpapi = template
        m.template_id = 'b5ee83e8-341b-4f59-b73c-cd496c514e48'
        m.text = "#{Event.first.name}"
        end

        res = client.send(mail)
        puts res.code
        puts res.body
    # end
    # 200
    # {"message"=>"success"}
    # You can also create a Mail object with a hash:
    #
    # res = client.send(SendGrid::Mail.new(to: 'example@example.com', from: 'taco@cat.limo', subject: 'Hello world!', text: 'Hi there!', html: '<b>Hi there!</b>'))
    # puts res.code
    # puts res.body



    # from = Email.new(email: 'test@sendgrid.com')
    # to = Email.new(email: 'bplindgren91@gmail.com')
    # subject = 'Hello'
    # content = Content.new(type: 'text/plain', value: 'from the other side')
    # mail = Mail.new(from, subject, to, content)
    #
    # sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    # response = sg.client.mail._('send').beta.post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.response_body
    # puts response.response_headers
  end
end
