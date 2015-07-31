React = require 'react'
fetch = require 'fetch'
_ = require 'underscore'

Option = require 'option'

module.exports = React.createClass
  getInitialState: ->
    options: _.shuffle @props.data.options
    title: @props.data.title
    id: @props.data.id

  componentDidMount: ->
    unless @state.options.length
      @getOptions()
    for tag in document.getElementsByTagName("meta")
      csrf_token = tag.content if tag.name is "csrf-token"
    @setState
      csrf_token: csrf_token

  getOptions: ->
    fetch("/polls/#{@props.params.id}",
      headers: {
        'Accept': 'application/json'
        'Content-Type': 'application/json'
      }
    )
      .then (response) =>
        response.json()
      .then (json) =>
        @setState
          id: json.id
          title: json.title
          options: _.shuffle json.options


  handleChange: (e) ->
    @setState
      title: e.target.value

  handleOptionsChange: (e) ->
    @setState
      options: e.target.value

  vote: (e) ->
    e.preventDefault()
    params =
      options: @state.options
      authenticity_token: @state.csrf_token
    # fetch('/polls/', {
    #   method: 'post'
    #   body: JSON.stringify params
    #   headers: {
    #     'Accept': 'application/json'
    #     'Content-Type': 'application/json'
    #   }
    #   credentials: 'same-origin'
    # })
    #   .then (response) =>
    #     response.json()
    #   .then (json) =>
    #     debugger
    #     @setState
    #       name: json.name

  render: ->
    options = @state.options?.map (option, index) ->
      <Option text={option.text} key={option.id} id={option.id} />
    <div className="poll">
      <h3 className="poll_header">{@state.title}</h3>
      <p>
        The Deadspin Preseason 25 will comprise the 25 teams that receive the most votes from you, our idiot readers. You are free to select as few or as many teams as you want—ballots can be cast with votes for one team or for 128. 
        <span className="quiet">(Voting ends Aug. 10.)</span>
      </p>
      <div className="options">
        {options}
      </div>
      <button onClick={@vote}>Vote</button>
    </div>

