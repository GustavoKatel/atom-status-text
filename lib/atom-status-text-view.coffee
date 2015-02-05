fs = require 'fs'

module.exports =
class AtomStatusTextView
  constructor: (serializeState) ->
    # Create root element
    @element = document.createElement('span')
    @element.classList.add('atom-status-text')

    # Create message element
    @element.textContent = "Status-Text is active!"

    @updateHandler = setInterval =>
      @processText()
    , atom.config.get('atom-status-text.updateInterval')*1000

  processText: ->
    message = atom.config.get('atom-status-text.message')
    if atom.config.get('atom-status-text.readFromFile')
      message = fs.readFileSync atom.config.get('atom-status-text.fileName'), 'utf8'

    @element.textContent = message


  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    clearTimeout @updateHandler
    @element.remove()

  getElement: ->
    @element
