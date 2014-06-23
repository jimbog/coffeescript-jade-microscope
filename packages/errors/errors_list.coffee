Template.meteorErrors.helpers
  errors: ->
    Errors.collection.find()

Template.meteorError.rendered = ->
  error = @data
  Meteor.defer ->
    Errors.collection.update(error._id, {$set: {seen: true}})