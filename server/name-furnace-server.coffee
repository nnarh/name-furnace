root = global
DEFAULT_SCORE = 1000

root.Meteor.publish 'theNames', ->
  currentUserId = @userId
  root.Names.find(createdBy: currentUserId)

root.Meteor.methods
  'insertNameData': (name) ->
    currentUserId = root.Meteor.userId()
    root.Names.insert
      name: name
      score: DEFAULT_SCORE
      createdBy: currentUserId
  'nextRound': (winnerId, loserId) ->
    currentUserId = root.Meteor.userId()
    
    winner = root.Names.findOne(winnerId)
    loser = root.Names.findOne(loserId)

    expectedScoreWinner = elo.getExpected(winner.score,loser.score)
    expectedScoreLoser = elo.getExpected(loser.score, winner.score)

    winnerNewScore = elo.updateRating(expectedScoreWinner, 1, winner.score)
    loserNewScore = elo.updateRating(expectedScoreLoser, 0, loser.score)

    Names.update({_id: winnerId}, {$set: {score: winnerNewScore}})
    Names.update({_id: loserId}, {$set: {score: loserNewScore}})
