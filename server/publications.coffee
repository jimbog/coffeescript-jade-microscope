Meteor.publish 'posts', ->
  return Posts.find()

Meteor.publish 'comments', (postId) ->
  return Comments.find(postId: postId)

Meteor.publish 'notifications', ->
  return Notifications.find()
