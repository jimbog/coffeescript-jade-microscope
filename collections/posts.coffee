@Posts = new Meteor.Collection 'posts'

Posts.allow
  insert: (userId, doc) ->
    #only allow if logged in
    return !! userId