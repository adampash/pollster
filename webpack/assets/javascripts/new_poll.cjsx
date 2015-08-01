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
    @setState
      title: e.target.value

  handleOptionsChange: (e) ->
    @setState
      options: e.target.value

  save: (e) ->
    e.preventDefault()
    params =
      title: @state.title
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
      <form>
        <label>Title</label>
        <input type="text" onChange={@handleChange} value={@state.title} />
        <textarea onChange={@handleOptionsChange} value={@state.options} />
        <button onClick={@save}>Create</button>
      </form>
    </div>
