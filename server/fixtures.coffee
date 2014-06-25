if Posts.find().count() == 0
  now = new Date().getTime()

  # create two users
  tomId = Meteor.users.insert
    profile:
      name: 'Tom Coleman'
  tom = Meteor.users.findOne(tomId)

  sachaId = Meteor.users.insert
    profile:
      name: 'Sacha Greif'
  sacha = Meteor.users.findOne(sachaId)

  telescopeId = Posts.insert
    title: 'Introducing Telescope'
    userId: sacha._id
    author: sacha.profile.name
    url: "http://sachagreif.com/introducing-telescope/"
    submitted: now - 7 * 3600 * 1000

  Comments.insert
    postId: telescopeId
    userId: tom._id
    author: tom.profile.name
    submitted: now - 5* 3600 * 1000
    body: 'Interesting project Sacha, can I get involved?'

  Comments.insert
    postId: telescopeId
    userId: sacha._id
    author: sacha.profile.name
    submitted: now - 5* 3600 * 1000
    body: 'You sure can Tom'

  Posts.insert
    title: "Meteor"
    userId: tom._id
    author: tom.profile.name
    url: "http://meteor.com"
    submitted: now - 10 * 3600 * 1000

  Posts.insert
    title: "The Meteor Book"
    userId: sacha._id
    author: sacha.profile.name
    url: "http://themeteorbook.com"

