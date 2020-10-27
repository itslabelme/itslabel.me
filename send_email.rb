require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: 'athira@rightsolutions.ae')
to = SendGrid::Email.new(email: 'asnathira@gmail.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: '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')
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers