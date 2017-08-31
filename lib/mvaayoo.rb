require 'faraday'

module Mvaayoo
  # send sms
  def self.send_message msg, receipient_no
  #  message = ["00", msg.each_byte.map { |b| b.to_s(16) }.join("00")].join
    message = msg
    http_conn '/mvaayooapi/MessageCompose', ["user=#{MVAAYOO_USER}:#{MVAAYOO_PASSWORD}", "receipientno=#{receipient_no}", "msgtype=4", "senderID=#{SENDER_ID}", "dcs=0", "msgtxt=#{message}", "ishex=1", "state=4", "msgtype=4", "ishex=1"] 
  end
 
  # check balance
  def self.balance
    http_conn '/mvaayooapi/APIUtil', ["user=#{MVAAYOO_USER}:#{MVAAYOO_PASSWORD}", "type=0"]
  end

  # http api handler
  def self.http_conn url, params
    conn = Faraday.new(url: 'http://api.mVaayoo.com') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    conn.get "#{url}?#{params.join('&')}"
  end
end
