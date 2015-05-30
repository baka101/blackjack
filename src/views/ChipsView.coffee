class window.ChipsView extends Backbone.View

  template: _.template('You have <%= numChips %> chips!
                      <button class="betButton">Bet</button>
                      <p>You bet <%= bet %> chips!')

  initialize: ->
    @render()
    @model.on 'change:bet', @render, @

  render: ->
    @$el.html @template @model.attributes

  events:
    "click .betButton": -> @model.setBet(100)

