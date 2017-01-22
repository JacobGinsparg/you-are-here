YouAreHereView = require './you-are-here-view'
{CompositeDisposable} = require 'atom'

module.exports = YouAreHere =
  youAreHereView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @youAreHereView = new YouAreHereView(state.youAreHereViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @youAreHereView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'you-are-here:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @youAreHereView.destroy()

  serialize: ->
    youAreHereViewState: @youAreHereView.serialize()

  toggle: ->
    console.log 'YouAreHere was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
