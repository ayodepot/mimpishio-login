MimpishioLoginView = require './mimpishio-login-view'
{CompositeDisposable} = require 'atom'

module.exports = MimpishioLogin =
  mimpishioLoginView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mimpishioLoginView = new MimpishioLoginView(state.mimpishioLoginViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mimpishioLoginView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mimpishio-login:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mimpishioLoginView.destroy()

  serialize: ->
    mimpishioLoginViewState: @mimpishioLoginView.serialize()

  toggle: ->
    console.log 'MimpishioLogin was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
