Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    [Meteor.subscribe('notifications')]

Router.map ->
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: ->
      Meteor.subscribe 'comments', @params._id
    data: -> Posts.findOne(@params._id)
  @route 'postSubmit',
    path: '/submit'
  @route 'postEdit',
    path: '/posts/:_id/edit'
    data: -> Posts.findOne(@params._id)
  @route 'postsList',
    path: '/:postsLimit?'
    waitOn: ->
      limit = parseInt(@params.postsLimit) or 5
      Meteor.subscribe('posts', {limit: limit})
    data: ->
      limit = parseInt(@params.postsLimit) or 5
      console.log limit
      posts: Posts.find({}, {limit: limit})


requireLogin = (pause) ->
  unless Meteor.user()
    @render 'accessDenied'
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, {only: 'postSubmit'}
Router.onBeforeAction -> Errors.clearSeen()
