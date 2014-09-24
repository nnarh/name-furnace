root = global

root.Meteor.publish 'theNames', ->
  currentUserId = @userId
  root.Names.find(createdBy: currentUserId)

root.Meteor.methods
  'insertNameData': (name) ->
    currentUserId = root.Meteor.userId()
    root.Names.insert
      name: name
      score: 0
      createdBy: currentUserId