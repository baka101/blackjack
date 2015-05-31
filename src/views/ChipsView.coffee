class window.ChipsView extends Backbone.View

  template: _.template('You have <%= numChips %> chips!
                      <button class="bet-button">Bet</button>
                      <p>You bet <%= bet %> chips!')

  initialize: ->
    @render()
    @model.on 'change', @render, @
    @model.on 'outtaMoney', @handleOuttaMoney, @

  events:
    "click .bet-button": -> @model.setBet(100)

  render: ->
    @$el.html @template @model.attributes

  handleOuttaMoney: ->
    $mrT = $('<div class="popup"><h1 class="inYourFace">You Outta Money Foo\'!</h1></div>')
    @$el.append $mrT

