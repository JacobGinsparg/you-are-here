/** @babel */

import YouAreHere from '../lib/you-are-here';

describe('YouAreHere', () => {
  let workspace = null;
  let editor = null;
  let activationPromise = null;

  beforeEach(() => {
    workspace = atom.workspace;
    waitsForPromise(() => {
      return atom.workspace.open().then((e) => {
        editor = e;
        YouAreHere.decorations[editor.id] = {};
      });
    });
    activationPromise = atom.packages.activatePackage('you-are-here');
  });

  describe('Unit Tests', () => {
    describe('YouAreHere::alreadyMarked', () => {
      it('should be true', () => {
        YouAreHere.decorations[editor.id][0] = {'This is': 'a dummy'};
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true);
      });

      it('should be false', () => {
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false);
      });
    });

    describe('YouAreHere::clearRow', () => {
      it('should destroy the decoration', () => {
        const marker = editor.markBufferPosition([0, 0]);
        const decoration = editor.decorateMarker(marker, {type: 'line-number', class: 'you-are-here'})
        YouAreHere.decorations[editor.id][0] = decoration;
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true);
        YouAreHere.clearRow(editor, 0);
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false);
      });
    });

    describe('YouAreHere::markRow', () => {
      it('should create the decoration', () => {
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false);
        YouAreHere.markRow(editor, 0);
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true);
      });
    });
  });

  describe('Behavior Tests', () => {
    describe('When you toggle', () => {
      it('should mark if unmarked', () => {
        editor.setCursorBufferPosition([0, 0]);
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false);
        YouAreHere.toggle();
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true);
      });

      it('should unmark if marked', () => {
        editor.setCursorBufferPosition([0, 0]);
        YouAreHere.toggle();
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(true);
        YouAreHere.toggle();
        expect(YouAreHere.alreadyMarked(editor, 0)).toBe(false);
      });
    });
  });
});
