{_, SERVER_HOSTNAME} = window
#Promise = require 'bluebird'
#async = Promise.coroutine
fs = require 'fs-extra'
path = require 'path-extra'

INTERVAL = 600      # seconds, time for a new tip
STICKY_TIME = 30    # seconds, time that the tip can't be refreshed by a "default"
list = null
PREFIX = "【小提示】"

update = ->
  # Post a random tip
  window.log PREFIX+list[Math.floor(Math.random() * list.length)],
    priority: 1
    stickyFor: STICKY_TIME*1000
  # Reinvoked after certain interval
  setTimeout update, INTERVAL*1000, list

firstUpdate = ->
  # A one-time version of update()
  # Note it must accepts no arguments to properly removeEventListener itself
  window.removeEventListener 'poi.alert', firstUpdate
  update list

fs.readJSON path.join(__dirname, 'assets', 'dyk-contents.json'), (err, packageObj) ->
  list = packageObj
  if !packageObj
    console.error 'Reading dyk-contents.json failed: ', err
  else
    window.addEventListener 'poi.alert', firstUpdate

module.exports =
  name: 'DoYouKnow'
  author: 'DKWings'
  displayName: <span><FontAwesome name='question-circle' /> 你知道吗 </span>
  link: 'https://github.com/dkwingsmt'
  description: '显示一些关于 poi 的小提示~'
  show: false
  version: '0.0.1'
