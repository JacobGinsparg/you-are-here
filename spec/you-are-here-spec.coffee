YouAreHere = require '../lib/you-are-here'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'YouAreHere', ->
  [workspace, editor, activationPromise] = []

  beforeEach ->
    workspace = atom.workspace
    waitsForPromise ->
      atom.workspace.open().then (e) ->
        editor = e
        YouAreHere.decorations[editor.id] = {}
    activationPromise = atom.packages.activatePackage('you-are-here')

  describe 'Unit Tests', ->
    describe 'YouAreHere::alreadyMarked', ->
      it 'should be true', ->
        YouAreHere.decorations[editor.id][0] = {'This is':'a dummy'}
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true)

      it 'should be false', ->
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false)

    describe 'YouAreHere::clearRow', ->
      it 'should destroy the decoration', ->
        marker = editor.markBufferPosition([0,0])
        decoration = editor.decorateMarker(marker,
          {type: 'line-number', class: 'you-are-here'})
        YouAreHere.decorations[editor.id][0] = decoration
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true)
        YouAreHere.clearRow(editor, 0)
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false)

    describe 'YouAreHere::markRow', ->
      it 'should create the decoration', ->
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false)
        YouAreHere.markRow(editor, 0)
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true)

  describe 'Behavior Tests', ->
    describe 'When you toggle', ->
      it 'should mark if unmarked', ->
        editor.setCursorBufferPosition [0,0]
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false)
        YouAreHere.toggle()
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true)

      it 'should unmark if marked', ->
        editor.setCursorBufferPosition [0,0]
        YouAreHere.toggle()
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true)
        YouAreHere.toggle()
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false)
