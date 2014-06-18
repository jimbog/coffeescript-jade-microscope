Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: -> return Meteor.subscribe('posts')

Router.map ->
  @route 'postsList', {path: '/'}
  @route 'postPage', {
    path: '/posts/:_id'
    data: -> return Posts.findOne(@params._id)
  }