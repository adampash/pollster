React = require 'react'
window.React = React
Router = require('react-router')
Link = Router.Link
Route = Router.Route
RouteHandler = Router.RouteHandler
NewPoll = require 'new_poll'
Poll = require 'poll'
Login = require 'login'
$ = require 'jquery'


App = React.createClass
  componentDidMount: ->
    window.addEventListener 'resize', @resize
    @resize()

  componentWillUnmount: ->
    window.removeEventListener 'resize', @resize

  resize: ->
    height = $('body').height() + 30
    window.top.postMessage(
      JSON.stringify(
        kinja:
          sourceUrl: window.location.href
          resizeFrame:
            height: height
      ), '*'
    )

  render: ->
    if @props.logged_in
      login = <div />
    else
      login = <Login data={@props.data} />
    <div>
      <RouteHandler {...@props} />
    </div>

routes =
  <Route handler={App} path="/">
    <Route name="new" path="/polls/new" handler={NewPoll} />
    <Route name="show" path="/polls/:id" handler={Poll} />
    <Route name="login" path="/login" handler={Login} />
  </Route>

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  params = state.params
  data = window.data
  React.render <Handler params={params} data={data} />, document.body
