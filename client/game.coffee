root = window

root.NameFurnace.game = {}

root.NameFurnace.game.setRandomNames = (names) ->
  nameIds = _.map names, (name) -> name._id

  firstId = root.Random.choice(nameIds)
  secondId = root.Random.choice(nameIds)
  while(firstId == secondId)
    secondId = root.Random.choice(nameIds)

  root.Session.set('firstNameId', firstId)
  root.Session.set('secondNameId', secondId)

root.NameFurnace.game.setupGame = ->
  names = root.Names.find().fetch()

  if names.length > 2
    root.NameFurnace.game.setRandomNames(names)
  else
    alert('you need more name choices')

root.Template.game.firstName = ->
  firstId = root.Session.get('firstNameId')
  firstName = root.Names.findOne(firstId)
  firstName.name if firstName

root.Template.game.secondName = ->
  secondId = root.Session.get('secondNameId')
  secondName = root.Names.findOne(secondId)
  secondName.name if secondName

root.Template.game.events
  'click #firstName': (e) ->
    firstNameId = root.Session.get('firstNameId')
    secondNameId = root.Session.get('secondNameId')
    root.Meteor.call('nextRound', firstNameId, secondNameId)
    root.NameFurnace.game.setupGame()
  'click #secondName': (e) ->
    firstNameId = root.Session.get('firstNameId')
    secondNameId = root.Session.get('secondNameId')
    root.Meteor.call('nextRound', secondNameId, firstNameId)
    root.NameFurnace.game.setupGame()
