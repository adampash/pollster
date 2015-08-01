React = require 'react'

module.exports = React.createClass
  render: ->
    <div>
      <a href={@props.data.login_path} className="login">Log in</a>
      <div className="login_message">
        Log in will redirect to your Google sign in. Please sign in only with your Gawker email address.
      </div>
    </div>
