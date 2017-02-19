{CompositeDisposable} = require 'atom'

module.exports = YouAreHere =
  subscriptions: null
  decorations: {}

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'you-are-here:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    console.log 'you-are-here toggled'
    editor = atom.workspace.getActiveTextEditor()
    row = editor.getCursorBufferPosition().row
    if @alreadyMarked(editor, row)
      @clearRow(editor, row)
    else
      @markRow(editor, row)

  alreadyMarked: (editor, row) ->
    (@decorations[editor.id] ? {})[row] isnt null

  clearRow: (editor, row) ->
    decoration = @decorations[editor.id][row]
    decoration.destroy()
    @decorations[editor.id][row] = null

  markRow: (editor, row) ->
    marker = editor.markBufferPosition([row, 0])
    decoration = editor.decorateMarker(marker,
      {type: 'line-number', class: 'you-are-here'})
    @decorations[editor.id] ?= {}
    @decorations[editor.id][row] = decoration
