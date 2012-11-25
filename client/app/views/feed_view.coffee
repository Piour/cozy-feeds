View = require '../lib/view'

module.exports = class FeedView extends View
    className: 'feed'
    tagName: 'div'

    events:
        'click .icon-delete': 'onDeleteClicked'

    constructor: (@model) ->
        super()
    
    template: ->
        template = require './templates/feed'
        template @getRenderData()

    onDeleteClicked: ->
        @model.destroy
            success: =>
                @destroy()
            error: =>
                alert "Server error occured, feed was not deleted."
