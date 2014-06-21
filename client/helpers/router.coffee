Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: -> return Meteor.subscribe('posts')

Router.map ->
  @route 'postsList',
    path: '/'
  @route 'postPage',
    path: '/posts/:_id'
    data: -> Posts.findOne(@params._id)
  @route 'postSubmit',
    path: '/submit'
  @route 'postEdit',
    path: '/posts/:_id/edit'
    data: -> Posts.findOne(@params._id)

requireLogin = (pause) ->
  unless Meteor.user()
    @render 'accessDenied'
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, {only: 'postSubmit'}