(function() {
  var root;
  root = this;

  root.yPlayer = {
    _default: {
      videoId: 'o9UQSUHHdtA'
    },
    init: function(options) {
      var firstScriptTag, tag;
      var self = this;

      options = jQuery.extend(this._default, options);
      tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      firstScriptTag = document.getElementsByTagName('script')[1];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      root.onYouTubeIframeAPIReady = (function() {
        return function() {
          var video;
          video = document.getElementById('Yplayer');
          root.player = new YT.Player(video, {
            height: '390',
            width: '640',
            wmode: 'transparent',
            videoId: options.videoId,
            playerVars: {
              wmode: 'transparent',
              controls: 0,
              showinfo: 0,
              rel: 0
            },
            events: {
              'onReady': self._onPlayerReady,
              'onStateChange': self._onPlayerStateChange,
              'onError': self._endIntro
            }
          });
        };
      })(this);
    },
    _onPlayerReady: function() {
      var playBtn = document.getElementById('playVideo');
      playBtn.className = playBtn.className.replace('hidden', '');
    },
    _onPlayerStateChange: function(event) {
      if (event.data === YT.PlayerState.ENDED) {
        return this.yPlayer._endIntro();
      }
    },
    _endIntro: function() {
      if (window.player !== null) { 
        window.player.seekTo(1, false); 
      }
      var overlay = document.getElementById('overlay'),
        play = document.getElementById('playVideo'),
        replay = document.getElementById('replay');

      overlay.className = overlay.className.replace('hidden', '');
      replay.className = replay.className.replace('hidden', '');
      play.className += 'hidden';

    }
  };

}).call(this);
