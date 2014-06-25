Meteor.publish 'posts', ->
  return Posts.find()

Meteor.publish 'comments', ->
  return Comments.find()
