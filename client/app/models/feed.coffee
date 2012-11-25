module.exports = class Feed extends Backbone.Model

    urlRoot: 'feeds'

    isNew: () ->
        not @id?
