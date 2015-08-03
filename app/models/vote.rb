class Vote < ActiveRecord::Base
  belongs_to :poll
  belongs_to :option
  belongs_to :ballot

  def self.create_all(options, ballot)
    options[:chosen].map do |option_id|
      create(
        option_id: option_id,
        poll_id: options[:poll_id],
        ballot_id: ballot.id,
        ip_address: ballot.ip_address,
      )
    end
  end
end
