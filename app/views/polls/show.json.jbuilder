json.id @poll.id
json.title @poll.title
json.description @poll.description
json.end_message @poll.end_message
json.live @poll.live
# json.text post.text
json.options do
  json.array! @poll.options do |option|
    json.text option.text
    json.id option.id
  end
end
