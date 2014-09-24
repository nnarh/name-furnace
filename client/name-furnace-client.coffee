root = window

root.Meteor.subscribe('theNames')

root.Template.allNames.names = ->
  currentUserId = root.Meteor.userId()
  root.Names.find({createdBy: currentUserId}, {sort: {score: -1, name: 1}})

root.Template.loggedIn.gameInProgress = ->
  root.Session.get('gameInProgress')

root.Template.game.firstName = ->
  root.Session.get('firstName')

root.Template.game.secondName = ->
  root.Session.get('secondName')

root.Template.addNameForm.events
  'submit form': (e, addNameTemplate) ->
    e.preventDefault()
    name = addNameTemplate.find('#nameText').value
    root.Meteor.call('insertNameData', name)

root.Template.header.events
  'click #startGame': (e) ->
    e.preventDefault()
    root.Session.set('gameInProgress', true)
  'click #endGame': (e) ->
    e.preventDefault()
    root.Session.set('gameInProgress', false)
