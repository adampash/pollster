json.id @poll.id
json.title @poll.title
# json.text post.text
json.options do
  json.array! @poll.options do |option|
    json.text option.text
    json.id option.id
  end
end
