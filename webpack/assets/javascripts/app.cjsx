React = require 'react'
window.React = React
Router = require('react-router')
Link = Router.Link
Route = Router.Route
RouteHandler = Router.RouteHandler
NewPoll = require 'new_poll'
Poll = require 'poll'
Login = require 'login'


App = React.createClass
  componentDidMount: ->
    window.addEventListener 'resize', @resize
    @resize()

  componentWillUnmount: ->
    window.removeEventListener 'resize', @resize

  resize: ->
    height = $('body').height() + 10
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

# Foo = require 'foo'
# 
# # using github's fetch browser shim
# fetch = require 'fetch'
# 
# HelloWorld = React.createClass
#   getInitialState: ->
#     name: @props.name
#   handleHover: ->
#     fetch('/pages/json.json')
#       .then (response) =>
#         response.json()
#       .then (json) =>
#         @setState
#           name: json.name
#       .catch (e) =>
#         console.log 'error'
#   #     debugger
#   render: ->
#     <div onMouseOver={@handleHover}>
#       <h2>
#         Hello {@state.name}
#       </h2>
#       <Foo name={@state.name} />
#     </div>
# 
# React.render(
#   <HelloWorld name="You" />,
#   document.body
# )
# 
# module.exports = HelloWorld
