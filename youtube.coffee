root = exports ? this

root.yPlayer = {
  _default: {
    videoId: 'o9UQSUHHdtA'
  }

  init: (options) ->
    options = jQuery.extend @_default, options

    # Async loading for youtube script
    tag = document.createElement('script')
    tag.src = "https://www.youtube.com/iframe_api"
    firstScriptTag = document.getElementsByTagName('script')[1]
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

    # Create youtube player when script is loaded
    root.onYouTubeIframeAPIReady = =>
      video = document.getElementById('Yplayer')
      root.player = new YT.Player(video, {
        height: '390',
        width: '640',
        videoId: options.videoId,
        playerVars: {
          autohide: 1,
          autoplay: 1,
          rel: 0
        },
        events: {
          'onReady': @_viewChange({'#view-loader'}, {'#view-video'}),
          'onStateChange': @_onPlayerStateChange,
          'onError': @endIntro
        }
      })

    @_bindings()

  # Clear up DOM and show products
  endIntro: ->
    root.player.destroy() if root.player?
    @_viewChange({'#view-video'}, {"#view-list", "#view-items"}, true)
    jQuery('#view-items').find('.row').inView()
    root.onScroll()

  # Check for state changes on the player
  _onPlayerStateChange: (event) ->
    @yPlayer.endIntro() if event.data == YT.PlayerState.ENDED

  #Hide and show views
  _viewChange: (from, to, removeCover = false) ->
    $overlay = jQuery(".overlay")
    if removeCover and $overlay then $overlay.fadeOut( 400, -> $overlay.remove() )

    jQuery.each from, (i, val) ->
      jQuery( val ).addClass 'hidden'

    jQuery.each to, (i, val) ->
      jQuery( val ).removeClass 'hidden'

  _bindings: ->
    # Skip video link click
    jQuery('.skipVideo').on 'click', (e) =>
      e.preventDefault()
      @endIntro()
}