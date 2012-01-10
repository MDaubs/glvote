window.GLVote ||= {}
window.GLVote.WorkerView = class GLVote.WorkerView
  constructor: (options) ->
    faye_client = new Faye.Client(options.faye_url, timeout: 24)
    faye_client.subscribe '/booths', (message) =>
      status_element = $("#booth_#{message.id} .human_status")
      voter_element  = $("#booth_#{message.id} .voter_name")
      status_element.text(message.human_status)
      status_element.attr("class", "human_status label #{message.css_class}")
      voter_element.text(message.voter_name)
