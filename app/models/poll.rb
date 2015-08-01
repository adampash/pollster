class Poll < ActiveRecord::Base
  has_many :options
  has_many :votes
  belongs_to :user

  def self.create_with_mass_options(options, user_id)
    poll = create(
      title: options[:title],
      live: true,
      vote_count: 0,
      user_id: user_id,
    )
    Option.mass_create(options[:options], poll.id)
    poll.save
    poll
  end
end
