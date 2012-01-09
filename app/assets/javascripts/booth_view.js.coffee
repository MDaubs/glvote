window.GLVote ||= {}
window.GLVote.BoothView = class GLVote.BoothView
  constructor: (options) ->
    @booth_id = parseInt(options.booth_id)
    @human_status = options.human_status
    faye_client = new Faye.Client(options.faye_url, timeout: 25)
    faye_client.subscribe '/booths', (message) =>
      if parseInt(message.id) == @booth_id && message.human_status != @human_status && (message.human_status == 'Inactive' || message.human_status == 'Ready For Voter')
        window.location.reload(true)
