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
    return {sort: @sort, limit: @limit()}

  waitOn: ->
    Meteor.subscribe('posts', @findOptions())

  posts: ->
    Posts.find({}, @findOptions())

  data: ->
    hasMore = @posts().count() == @limit()
    return {
      posts: @posts()
      nextPath: if hasMore then @nextPath() else null
    }

NewPostsController = PostsListController.extend
  sort: {submitted: -1, _id: -1}
  nextPath: ->
    Router.routes.newPosts.path({postsLimit: @limit() + @increment})

BestPostsListController = PostsListController.extend
  sort: {votes: -1, submitted: -1, _id: -1}
  nextPath: ->
    Router.routes.bestPosts.path({postsLimit: @limit() + @increment})


# routes
Router.map ->
  @route 'home',
    path: '/'
    controller: NewPostsController

  @route 'newPosts',
    path: '/new/:postsLimit?'
    controller: NewPostsController

  @route 'bestPosts',
    path: 'best/:postsLimit?'
    controller: BestPostsListController

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
