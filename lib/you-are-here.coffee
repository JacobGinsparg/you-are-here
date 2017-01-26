{CompositeDisposable} = require 'atom'

module.exports = YouAreHere =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'you-are-here:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    console.log 'you-are-here toggled'
    editor = atom.workspace.getActiveTextEditor()
    range = editor.getSelectedBufferRange()
    marker = editor.markBufferRange(range)
    decoration = editor.decorateMarker(marker, {type: 'line-number', class: 'you-are-here'})
