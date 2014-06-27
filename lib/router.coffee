# configuration
Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    [Meteor.subscribe('notifications')]

# controllers
PostsListController = RouteController.extend
  template: 'postsList'
  increment: 5
  limit: ->
    parseInt(@params.postsLimit) or @increment
  findOptions: ->
    return {sort: {submitted: -1}, limit: @limit()}
  waitOn: ->
    Meteor.subscribe 'posts', @findOptions()
  data: ->
    {posts: Posts.find({}, @findOptions())}

# routes
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
    controller: PostsListController


requireLogin = (pause) ->
  unless Meteor.user()
    @render 'accessDenied'
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, {only: 'postSubmit'}
Router.onBeforeAction -> Errors.clearSeen()
