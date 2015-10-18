{_, SERVER_HOSTNAME} = window
#Promise = require 'bluebird'
#async = Promise.coroutine
fs = require 'fs-extra'
path = require 'path-extra'

seq = 0

update = (list) ->
  window.log list[seq]
  seq = (seq+1) % list.length

fs.readJSON path.join(__dirname, 'dyk-contents.json'), (err, packageObj) ->
  if !packageObj
    console.log 'Reading dyk-contents.json failed: ', err
  else
    setInterval update, 1000, packageObj

module.exports =
  name: 'DoYouKnow'
  author: 'DKWings'
  displayName: <span><FontAwesome name='question-circle' /> 你知道吗 </span>
  description: '显示一些关于 poi 的小提示~'
  show: false
  version: '0.0.1'
