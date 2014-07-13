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
    Meteor.subscribe('posts', @findOptions())

  posts: ->
    Posts.find({}, @findOptions())

  data: ->
    hasMore = @posts().count() == @limit()
    nextPath = @route.path
      postsLimit: @limit() + @increment

    return {
      posts: @posts()
      nextPath: if hasMore then nextPath else null
    }

# routes
Router.map ->
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: ->
      return [
        Meteor.subscribe('singlePost', @params._id)
        Meteor.subscribe('comments', @params._id)
        ]
    data: -> Posts.findOne(@params._id)

  @route 'postSubmit',
    path: '/submit'

  @route 'postEdit',
    path: '/posts/:_id/edit'
    waitOn: ->
      Meteor.subscribe('singlePost', @params._id)
    data: ->
      Posts.findOne(@params._id)

  @route 'postsList',
    path: '/:postsLimit?'
    controller: PostsListController


requireLogin = (pause) ->
  if not Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, {only: ['postSubmit', 'postEdit']}
Router.onBeforeAction -> Errors.clearSeen()
