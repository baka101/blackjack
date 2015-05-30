class window.ChipsView extends Backbone.View

  template: _.template('You have <%= numChips %> chips!
                      <button class="bet-button">Bet</button>
                      <p>You bet <%= bet %> chips!')

  initialize: ->
    @render()
    @model.on 'change', @render, @

  render: ->
    @$el.html @template @model.attributes

  events:
    "click .bet-button": -> @model.setBet(100)

