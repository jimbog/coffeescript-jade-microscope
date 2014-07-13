Template.postEdit.events
  'submit form': (e) ->
    e.preventDefault()
    currentPostId = @_id

    postProperties =
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()

    Posts.update currentPostId, {$set: postProperties}, (error) ->
      #display the error to the user
      if error
        console.log error.reason
        alert error.reason
        Errors.throw(error.reason)
      else
        Router.go 'postPage',
          _id: currentPostId
  'click .delete': (e) ->
    e.preventDefault()

    if confirm("Delete this post?")
      currentPostId = @_id
      Posts.remove(currentPostId)
      Router.go 'home'

