{CompositeDisposable} = require 'atom'
SubAtom = require 'sub-atom'

module.exports = YouAreHere =
  subscriptions: null
  gutterSubs: null
  decorations: {}
  mouseEvent: (e) => YouAreHere.toggle()

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'you-are-here:toggle': => @toggle()
    @gutterSubs = new SubAtom
    atom.packages.onDidActivateInitialPackages =>
      @gutterSubs.add '.line-number', 'click', @mouseEvent

  deactivate: ->
    @subscriptions.dispose()
    @gutterSubs.dispose()

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    row = editor.getSelectedBufferRange().start.row
    if @alreadyMarked(editor, row)
      @clearRow(editor, row)
    else
      @markRow(editor, row)

  alreadyMarked: (editor, row) ->
    (@decorations[editor.id] ? {})[row]?

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
