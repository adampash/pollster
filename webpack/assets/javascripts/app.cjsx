React = require 'react'
window.React = React
Router = require('react-router')
Link = Router.Link
Route = Router.Route
RouteHandler = Router.RouteHandler
NewPoll = require 'new_poll'
Poll = require 'poll'

routes =
  <Route handler={App} path="/">
    <Route name="new" path="/polls/new" handler={NewPoll} />
    <Route name="show" path="/polls/:id" handler={Poll} />
  </Route>


App = React.createClass
  render: ->
    <div>
      Hello world
      <RouteHandler/>
    </div>

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
