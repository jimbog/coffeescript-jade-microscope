Template.meteorErrors.helpers
  errors: ->
    Errors.collection.find()

Template.meteorError.rendered = ->
  error = @data
  Meteor.defer ->
    console.log 'entering defer'
    console.log error
    Errors.collection.update(error._id, {$set: {seen: true}})
    console.log(Errors.collection.findOne({_id: error._id}))
    console.log 'leaving defer'
    return null