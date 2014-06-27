Meteor.publish 'posts', (options) ->
  return Posts.find({}, options)

Meteor.publish 'comments', (postId) ->
  return Comments.find(postId: postId)

Meteor.publish 'notifications', ->
  return Notifications.find({userId: @userId})
