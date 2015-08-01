React = require 'react'
fetch = require 'fetch'
_ = require 'underscore'
classnames = require 'classnames'

Option = require 'option'

module.exports = React.createClass
  getInitialState: ->
    options: _.shuffle @props.data?.options
    title: @props.data?.title
    description: @props.data?.description
    end_message: @props.data?.end_message
    id: @props.params.id
    chosen: []
    voted: false
    loading: false

  componentDidMount: ->
    unless @state.options.length
      @getOptions()
    for tag in document.getElementsByTagName("meta")
      csrf_token = tag.content if tag.name is "csrf-token"
    @setState
      csrf_token: csrf_token

  getOptions: ->
    console.log 'fetching options'
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
          description: json.description
          end_message: json.end_message
          options: _.shuffle json.options

  add: (option_id) ->
    chosen = @state.chosen
    chosen.push(option_id)
    @setState
      chosen: chosen

  remove: (option_id) ->
    @setState
      chosen: _.without(@state.chosen, option_id)

  vote: (e) ->
    e.preventDefault()
    return if @state.voted or @state.loading
    unless @state.chosen.length > 0
      alert("Choose some teams, dummy!")
      return
    params =
      chosen: @state.chosen
      authenticity_token: @state.csrf_token
    @setState
      loading: true
    fetch("/polls/#{@state.id}/votes", {
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
        # debugger
        @setState
          voted: true
          loading: false
      .catch (e) =>
        alert 'something went wrong'
        @setState
          loading: false

  render: ->
    console.log @state.chosen
    options = @state.options?.map (option, index) =>
      <Option text={option.text} key={option.id} id={option.id}
        add={@add}
        remove={@remove}
        voted={@state.voted}
      />
    button = <button
              className={classnames(
                "vote",
                loading: @state.loading,
                voted: @state.voted
              )}
              disabled={@state.loading or @state.voted}
              onClick={@vote} />


    <div className="poll">
      <h3 className="interactive">Interactive</h3>
      <h3 className="poll_header">{@state.title}</h3>
      <p>
        {@state.description}
        <span className="quiet"> ({@state.end_message})</span>
      </p>
      <div className="options">
        {options}
      </div>
      {button}
    </div>

