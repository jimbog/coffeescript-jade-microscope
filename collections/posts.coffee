@Posts = new Meteor.Collection 'posts'

Meteor.methods
  post: (postAttributes) ->
    user = Meteor.user()
    postWithSameLink = Posts.findOne url: postAttributes.url

    #ensure the user is logged in
    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    #ensure the post hass a title
    if !postAttributes.title
      throw new Meteor.Error(422, "Please fill in a headline")

    #check that there are no previous posts with the same link
    if postAttributes.url and postWithSameLink
      throw new Meteor.Error(302, 'This link has already been posted', postWithSameLink)

    #pick out the whitelisted keys
    post = _.extend _.pick(postAttributes, 'url', 'title', 'message'),
                    title: postAttributes.title + (if @isSimulation then '(client)' else '(server)')
                    userId: user._id
                    author: user.username
                    submitted: new Date().getTime()

    if @isSimulation
      console.log post.title

    #wait for 5 seconds
    if (! @isSimulation)
      Future = Npm.require('fibers/future')
      future = new Future()
      Meteor.setTimeout (-> future.return()), 5 * 1000
      future.wait()

    postId = Posts.insert(post)

    return postId

