/** @babel */
import { CompositeDisposable } from 'atom';

const YouAreHere = {
  subscriptions: null,
  decorations: {},

  activate(state) {
    this.subscriptions = new CompositeDisposable;
    this.subscriptions.add(atom.commands.add('atom-workspace', {'you-are-here:toggle': () => this.toggle()}));
  },

  deactivate() {
    this.subscriptions.dispose();
  },

  toggle() {
    const editor = atom.workspace.getActiveTextEditor();
    const row = editor.getCursorBufferPosition().row;
    if (this.alreadyMarked(editor, row)) {
      this.clearRow(editor, row);
    } else {
      this.markRow(editor, row);
    }
  },

  alreadyMarked(editor, row) {
    const decoration = (this.decorations[editor.id] || {})[row] || null;
    return decoration !== null;
  },

  clearRow(editor, row) {
    const decoration = this.decorations[editor.id][row];
    decoration.destroy();
    this.decorations[editor.id][row] = null;
  },

  markRow(editor, row) {
    const marker = editor.markBufferPosition([row, 0]);
    const decoration = editor.decorateMarker(marker, {type: 'line-number', class: 'you-are-here'});
    if (this.decorations[editor.id] !== null) {
      this.decorations[editor.id] = {[row]: decoration};
    } else {
      this.decorations[editor.id][row] = decoration;
    }
  }
};

export default YouAreHere;
