class window.CardView extends Backbone.View
  className: 'card'

  template: _.template 'url(img/cards/<%= rankName %>-<%= suitName %>.png)'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.css 'background-size', 'contain'
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get 'revealed'
      @$el.css 'background-image', @template @model.attributes
    else
      @$el.css 'background-image', 'url(img/card-back.png)'
