# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  winner: null

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', =>
      @set 'winner', 'dealer'
    @get('dealerHand').on 'bust', =>
      @set 'winner', 'player'
    @get('playerHand').on 'stand', @callDealerTurn
    @get('dealerHand').on 'stand', =>
      playerScore = @get('playerHand').checkScore()
      dealerScore = @get('dealerHand').checkScore()
      @compareScores playerScore, dealerScore


  compareScores: (playerScore, dealerScore) ->
    if playerScore == dealerScore
      @set 'winner', 'tie'
    else if playerScore > dealerScore
      @set 'winner', 'player'
    else if playerScore < dealerScore
      @set 'winner', 'dealer'

  callDealerTurn: =>
    @get('dealerHand').dealerTurn()
