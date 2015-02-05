AtomStatusTextView = require './atom-status-text-view'
{CompositeDisposable} = require 'atom'

module.exports =

  # configDefaults:
  #   leftMessage: true
  #   message: 'Hello World'
  #   updateInterval: 3

  config:
    leftMessage:
      type: 'boolean'
      default: true
    readFromFile:
      type: 'boolean'
      default: false
    fileName:
      type: 'string'
      default: '~/filename.txt'
    message:
      type: 'string'
      default: 'Hello World'
    updateInterval:
      type: 'integer'
      minimum: 1
      default: 3

  atomStatusTextView: null
  subscriptions: null

  activate: (state) ->
    @atomStatusTextView = new AtomStatusTextView(state.atomStatusTextViewState)

    @statusBar = document.querySelector('status-bar')

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-status-text:run': => @run()

  deactivate: ->
    @subscriptions.dispose()
    @atomStatusTextView.destroy()

  serialize: ->
    atomStatusTextViewState: @atomStatusTextView.serialize()

  run: ->
    console.log 'ok: ' + atom.config.get('atom-status-text.fileName')

    if atom.config.get('atom-status-text.leftMessage')
      console.log 'left'
      @statusBar.addLeftTile(item: @atomStatusTextView.getElement(), priority: 100)
    else
      console.log 'right'
      @statusBar.addRightTile(item: @atomStatusTextView.getElement(), priority: 100)
