root = window

root.Meteor.subscribe('theNames')

root.Template.allNames.names = ->
  currentUserId = root.Meteor.userId()
  root.Names.find({createdBy: currentUserId}, {sort: {score: -1, name: 1}})

root.Template.loggedIn.gameInProgress = ->
  root.Session.get('gameInProgress')
