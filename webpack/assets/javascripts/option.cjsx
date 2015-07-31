React = require 'react'
classnames = require 'classnames'
Tappable = require 'react-tappable'

module.exports = React.createClass
  getInitialState: ->
    selected: false

  handleClick: (e) ->
    newSelect = !@state.selected
    @setState
      selected: newSelect
    # if newSelect
    #   @props.remove(@props.id)

  render: ->
    <Tappable className={classnames('option', selected: @state.selected)} onTap={@handleClick}>
      {@props.text}
    </Tappable>
