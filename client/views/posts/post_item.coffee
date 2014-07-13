Template.postItem.helpers
  ownPost: -> @userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @url
    return a.hostname
  upvotedClass: ->
    userId = Meteor.userId()
    if (userId and !_.include(@upvoters, userId))
      return 'btn-primary upvotable'
    else
      return 'disable'

Template.postItem.events
  'click .upvote': (e) ->
    e.preventDefault()
    Meteor.call('upvote', @_id)
