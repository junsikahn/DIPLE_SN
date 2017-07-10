class SendPinJob < ApplicationJob
  queue_as :default

  def perform(user)
    pin = rand(1000..9999)
    user.update_columns(pin: pin, pin_sent_at: Time.now, verified_at: nil)

    # SMS 전송 (청기와랩 API, SMS 건당 20원)
    # url = URI.encode('https://api.bluehouselab.com/smscenter/v1.0/sendsms')
    # resource = RestClient::Resource.new(url, "#{ENV['sms_app_id']}", "#{ENV['sms_api_key']}")
    # resource.post({
    #   sender: '01088627156',
    #   receivers: ["#{user.phone}"],
    #   content: "#{user.name}님의 인증번호는 #{user.pin}입니다"
    # }.to_json, 'Content-Type' => 'application/json; charset=utf-8')
  end
end
