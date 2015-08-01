class Vote < ActiveRecord::Base
  belongs_to :poll
  belongs_to :option

  def self.create_all(options, ip_address)
    options[:chosen].map do |option_id|
      create(
        option_id: option_id,
        poll_id: options[:poll_id],
        ip_address: ip_address,
      )
    end
  end
end
