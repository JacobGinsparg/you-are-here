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
      @clearRange(editor, row)
    else
      @markRange(editor, row)

  alreadyMarked: (editor, row) ->
    console.log 'Already marked?'
    (@decorations[editor.id] ? {})[row]

  clearRange: (editor, row) ->
    console.log 'Unmarking line'
    decoration = @decorations[editor.id][row]
    decoration.destroy()
    @decorations[editor.id][row] = null

  markRange: (editor, row) ->
    console.log 'Marking line'
    marker = editor.markBufferPosition([row, 0])
    decoration = editor.decorateMarker(marker,
      {type: 'line-number', class: 'you-are-here'})
    @decorations[editor.id] ?= {}
    @decorations[editor.id][row] = decoration
