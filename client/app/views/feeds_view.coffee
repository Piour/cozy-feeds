ViewCollection = require '../lib/view_collection'
FeedView       = require './feed_view'
FeedCollection = require '../collections/feed_collection'

module.exports = class FeedsView extends ViewCollection
    el: '.feeds'

    view: FeedView

    renderOne: (model) =>
        view = new @view model
        @$el.append view.render().el
        @add view
        @

    initialize: ->
        @collection = new FeedCollection @

