Template.postItem.helpers
  ownPost: -> @userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @url
    return a.hostname

Template.postItem.helpers
  'click .upvote': (e) ->
    e.preventDefault()
    Meteor.call('upvote', @_id)
