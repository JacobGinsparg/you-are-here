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
    position = editor.getCursorBufferPosition()
    if @alreadyMarked(editor, position)
      @clearRange(editor, position)
    else
      @markRange(editor, position)

  alreadyMarked: (editor, position) ->
    console.log 'Already marked?'
    (@decorations[editor.id] ? {})[position.row]

  clearRange: (editor, position) ->
    console.log 'Unmarking line'
    decoration = @decorations[editor.id][position.row]
    decoration.destroy()
    @decorations[editor.id][position.row] = null

  markRange: (editor, position) ->
    console.log 'Marking line'
    row = position.row
    marker = editor.markBufferPosition([row, 0])
    decoration = editor.decorateMarker(marker,
      {type: 'line-number', class: 'you-are-here'})
    @decorations[editor.id] ?= {}
    @decorations[editor.id][row] = decoration
