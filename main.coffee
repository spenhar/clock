# TODO: compile into .js

# Utils
log =
  error: () ->
    args = Array.prototype.slice.call arguments
    args.unshift 'ERROR:'
    console.log args
    console.trace()

# DOM helpers
id = (name) ->
  document.getElementById name

# API helpers
api =
  xhr: (type, url, data, callback) ->
    req = new XMLHttpRequest 'MSXML2.XMLHTTP.3.0'
    req.open type, url, true
    req.setRequestHeader 'Content-type', 'application/x-www-form-urlencoded'
    req.onreadystatechange = () ->
      if req.readyState == 4
        if req.status < 400
          output = req.responseText
          try
            output = JSON.parse output
          catch err
            #
          return callback null, output
        else
          return callback new Error "#{req.status}: #{req.responseText}"
    if data
      req.send data
    else
      req.send()
  get: (url, callback) ->
    api.xhr 'GET', url, null, callback

  getFounders: (callback) ->
    reserve = 'https://reserve.thegrid.io'
    url = "#{reserve}/serial/f6a4bd8d-55ec-4c3a-9ccd-9c5f3df80802/latest"
    return api.get url, callback
  getActivated: (callback) ->
    endpoint = 'http://api.thegrid.io'
    api.get "#{endpoint}/activated", (err, data) ->
      return callback err if err
      return callback new Error 'Did not get activated data' if not data.activated?
      return callback null, data.activated

# Main
main = () ->
  pollInterval = 2*60*1000

  update = () ->
    api.getFounders (err, founders) ->
      return log.error err if err
      id('foundingMembers').innerHTML = founders
    api.getActivated (err, active) ->
      return log.error err if err
      id('activeUsers').innerHTML = active

  update() # fire first one right away
  setInterval update, pollInterval

main()
