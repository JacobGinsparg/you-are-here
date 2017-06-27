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
  }
};

export default YouAreHere;
