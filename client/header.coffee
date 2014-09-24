root = window

root.Template.header.events
  'click #startGame': (e) ->
    e.preventDefault()
    root.Session.set('gameInProgress', true)
    root.NameFurnace.game.setupGame() unless root.Session.get('firstNameId') && root.Session.get('secondNameId')
  'click #endGame': (e) ->
    e.preventDefault()
    root.Session.set('gameInProgress', false)
