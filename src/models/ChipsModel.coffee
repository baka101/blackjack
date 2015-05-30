class window.ChipsModel extends Backbone.Model

  initialize: ->
    @set 'numChips', 1000
    @set 'bet', 0


  setBet: (betAmount) ->
    if betAmount <= @get 'numChips'
      @set 'bet', @get('bet') + betAmount
      @set 'numChips', @get('numChips') - betAmount
    else
      alert "You outta money foo'!"

  dealerWin: ->
    @set 'bet', 0

  playerWin: ->
    @set 'numChips', @get('numChips') + (2 * @get 'bet')
    @set 'bet', 0

  tie: ->
    @set 'numChips', @get('numChips') + (@get 'bet')
    @set 'bet', 0
