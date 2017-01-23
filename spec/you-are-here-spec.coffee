YouAreHere = require '../lib/you-are-here'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'YouAreHere', ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('you-are-here')

  describe 'when the you-are-here:toggle event is triggered', ->
    it 'still has tests', ->
      expect('tests').not.toBe('here')
