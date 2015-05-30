class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @showScore()

  showScore: ->
    highScore = @collection.scores()[1]
    lowScore = @collection.scores()[0]

    if @collection.hasAce() and (highScore <= 21)
      @$('.score').text "#{lowScore}, #{highScore}"
    else
      @$('.score').text lowScore
