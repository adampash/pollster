KinjaResizer =
  componentDidMount: ->
    @resize()
    window.addEventListener 'resize', @resize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @resize

  resize: ->
    height = @getHeight() + 30
    # console.log height
    window.top.postMessage(
      JSON.stringify(
        kinja:
          sourceUrl: window.location.href
          resizeFrame:
            height: height
      ), '*'
    )


  getHeight: ->
    body = document.body
    html = document.documentElement

    height = Math.max html.scrollHeight, html.offsetHeight

module.exports = KinjaResizer
