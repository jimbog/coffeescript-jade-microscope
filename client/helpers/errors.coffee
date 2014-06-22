#local collection
@Errors = new Meteor.Collection(null)

@throwError = (message) ->
  Errors.insert {message: message, seen: false}

@cleanErrors = ->
  Errors.remove {seen: true}