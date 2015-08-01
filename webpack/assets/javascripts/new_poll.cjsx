React = require 'react'
Router = require('react-router')
fetch = require 'fetch'

module.exports = React.createClass
  mixins: [Router.Navigation]

  getInitialState: ->
    title: ''

  componentDidMount: ->
    for tag in document.getElementsByTagName("meta")
      csrf_token = tag.content if tag.name is "csrf-token"
    @setState
      csrf_token: csrf_token

  handleChange: (e) ->
    obj = {}
    obj[e.target.name] = e.target.value
    @setState obj

  handleOptionsChange: (e) ->
    @setState
      options: e.target.value

  save: (e) ->
    e.preventDefault()
    params =
      title: @state.title
      description: @state.description
      end_message: @state.end_message
      options: @state.options
      mass: true
      authenticity_token: @state.csrf_token
    fetch('/polls/', {
      method: 'post'
      body: JSON.stringify params
      headers: {
        'Accept': 'application/json'
        'Content-Type': 'application/json'
      }
      credentials: 'same-origin'
    })
      .then (response) =>
        response.json()
      .then (json) =>
        @transitionTo('show', {id: json.id, data: json})

  render: ->
    <div>
      <form className="new_poll">
        <div className="group">
          <label>Title:</label>
          <input type="text" className="title" name="title" onChange={@handleChange} value={@state.title} />
        </div>
        <div className="group">
          <label>Description:</label>
          <input type="text" className="description" name="description" onChange={@handleChange} value={@state.description} />
        </div>
        <div className="group">
          <label>End message:</label>
          <input type="text" className="end_message" name="end_message" onChange={@handleChange} value={@state.end_message} placeholder="E.g., Voting ends Aug. 10." />
        </div>
        <div className="group">
          <label>Options (one per line):</label>
          <textarea onChange={@handleOptionsChange} value={@state.options} />
        </div>
        <div className="group">
          <button onClick={@save}>Create</button>
        </div>
      </form>
    </div>
