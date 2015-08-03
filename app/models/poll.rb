class Poll < ActiveRecord::Base
  has_many :options
  has_many :votes
  belongs_to :user

  def self.create_with_mass_options(options, user_id)
    poll = create(
      title: options[:title],
      description: options[:description],
      end_message: options[:end_message],
      live: true,
      vote_count: 0,
      user_id: user_id,
    )
    Option.mass_create(options[:options], poll.id)
    poll.save
    poll
  end

  def tally_results
    results = ""
    options.each do |option|
      results += "#{option.text}: #{option.votes.count}\n"
    end
    puts results
  end
end
