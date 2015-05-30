class window.ChipsModel extends Backbone.Model

  initialize: ->
    @set 'numChips', 1000
    @set 'bet', 0


  setBet: (betAmount) ->
    @set 'bet', @get('bet') + betAmount
