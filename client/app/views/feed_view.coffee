View = require '../lib/view'

module.exports = class FeedView extends View
    className: 'feed'
    tagName: 'div'

    events:
        'click': 'onUpdateClicked'
        'click .icon-delete': 'onDeleteClicked'

    constructor: (@model) ->
        @link_template = require './templates/link'
        super()
    
    template: ->
        template = require './templates/feed'
        template @getRenderData()

    from: ->
        title = @model.attributes.title
        title = title.replace(/\s/g, "")
        title

    renderLinks: ->
        $xml   = $($.parseXML(@model.attributes.content))
        $items = $xml.find("item").get()
        $items.reverse()
        from   = @from()
        tmpl   = @link_template
        $.each $items, 
            (index, value) -> 
                title = $(value).find("title").text()
                url   = $(value).find("link").text()
                link = { "title": title, "url": url, "from": from }
                $(".links").prepend(tmpl(link)) 
                if index >= 9
                    false

    onUpdateClicked: (evt) ->
        from = @from()
        existing = $(".links ." + from)
        if existing.length
            existing.remove()
        else
            @model.save {},
                success: =>
                    @.renderLinks()
                error: =>
                    alert "Server error occured, feed was not deleted."
        evt.preventDefault() 

    onDeleteClicked: ->
        @model.destroy
            success: =>
                @destroy()
            error: =>
                alert "Server error occured, feed was not deleted."
        evt.preventDefault() 
