require 'sendgrid-ruby'

module SendGrid
  def send_email(paypal_invoice_id, to_email)
    @event_name = self.name
    @url = "https://www.sandbox.paypal.com/us/cgi-bin/?cmd=_pay-inv&id=#{paypal_invoice_id}"

    # Create a new SendGrid client
    client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

    template = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' ><head><meta name='viewport' content='width=device-width' /><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><title>plum. invoice</title></head><body style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; width: 100% !important; height: 100%; line-height: 1.6em; background-color: #f6f6f6; margin: 0; padding: 0;' bgcolor='#f6f6f6'>&#13;&#13;<table class='body-wrap' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;' bgcolor='#f6f6f6'><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;' valign='top'></td>&#13;<td class='container' width='600' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; width: 100% !important; margin: 0 auto; padding: 0;' valign='top'>&#13;<div class='content' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 642px; width:642px; display: block; margin: 0 auto; padding: 20px 0 0 0;'>&#13;<table class='main' width='100%' cellpadding='0' cellspacing='0' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;' bgcolor='#fff'><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='alert alert-warning' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 26px; vertical-align: top; color: #fff; font-weight: 500; text-align: center; border-radius: 3px 3px 0 0; background-color: #905A90; margin: 0;' align='center' bgcolor='#FF9F00' valign='top'>&#13;<a style='text-decoration:none;color: #fff;' href='http://plumpayments.herokuapp.com'><img src='http://i.imgur.com/2H9EarZ.jpg'></a>&#13;</td>&#13;</tr><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='content-wrap' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 10px;' valign='top'>&#13;<table width='100%' cellpadding='0' cellspacing='0' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='content-block' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;' valign='top'>&#13;You have a <strong style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'>new invoice</strong> for #{@event_name}.&#13;</td>&#13;</tr><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='content-block' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;' valign='top'>&#13;Head over to paypal to review your expenses.&#13;</td>&#13;</tr><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='content-block' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;' align='center' valign='top'>&#13;<a href='#{@url}' class='btn-primary' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; font-style: oblique; color: #FFF; text-decoration: none; line-height: 2em; font-weight: bold; text-align: center; cursor: pointer; display: inline-block; border-radius: 5px; text-transform: capitalize; background-color: #6AAAA0; margin: 0; border-color: #6AAAA0; border-style: solid; border-width: 10px 20px;'>View Paypal Invoice</a>&#13;</td>&#13;</tr><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'></tr></table></td>&#13;</tr></table><div class='footer' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0;'>&#13;<table width='100%' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;padding: 5px 0 0 0;'><tr style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;'><td class='aligncenter content-block' style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 12px; vertical-align: top; color: #999; text-align: center; margin: 0; padding: 0;' align='center' valign='top'>Made with <img height=12px width=12px src='http://i.imgur.com/KFfhFhx.jpg'> at DevBootCamp Chicago</td>&#13;</tr></table></div></div>&#13;</td>&#13;<td style='font-family: Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;' valign='top'></td>&#13;</tr></table></body></html>"

    # Create a new Mail object and send:
    mail = SendGrid::Mail.new do |m|
      # m.to = 'bplindgren91@gmail.com'
      m.to = to_email
      m.from = 'dbcfsplum-facilitator@gmail.com'
      m.subject = 'bottom thing centered?'
      m.html = template
    end

    res = client.send(mail)
    puts res.code
    puts res.body
  end
end
