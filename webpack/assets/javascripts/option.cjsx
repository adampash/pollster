React = require 'react'
classnames = require 'classnames'
Tappable = require 'react-tappable'

module.exports = React.createClass
  getInitialState: ->
    selected: false

  handleClick: (e) ->
    if @props.voted
      return alert "Hey, you already voted! Why are you still clicking on things?"
    newSelect = !@state.selected
    @setState
      selected: newSelect
    if newSelect
      @props.add(@props.id)
    else
      @props.remove(@props.id)

  render: ->
    <Tappable
      className={classnames('option', selected: @state.selected)}
      onTap={@handleClick}
      moveThreshold={10}
    >
      {@props.text}
    </Tappable>
