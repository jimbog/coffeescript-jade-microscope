Template.postItem.helpers
  domain: ->
    a = document.createElement('a')
    a.href = @url
    return a.hostname