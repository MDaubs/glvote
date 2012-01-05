window.GLVote ||= {}
window.GLVote.InactiveBoothView = class GLVote.InactiveBoothView
  constructor: (options) ->
    @booth_id = parseInt(options.booth_id)
    @human_status = options.human_status
    faye_client = new Faye.Client(options.faye_url, timeout: 25)
    faye_client.subscribe '/booths', (message) =>
      if parseInt(message.id) == @booth_id && message.human_status != @human_status
        window.location.reload(true)
