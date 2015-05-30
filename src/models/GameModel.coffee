class window.GameModel extends Backbone.Model



  initialize: ->
    @set 'winner', null
    @dealNewDeck()
    @setupEventListeners()

  compareScores: (playerScore, dealerScore) ->
    if playerScore == dealerScore
      @set 'winner', 'tie'
    else if playerScore > dealerScore
      @set 'winner', 'player'
    else if playerScore < dealerScore
      @set 'winner', 'dealer'
    @trigger 'gotWinner', @

  callDealerTurn: =>
    @get('dealerHand').dealerTurn()

  dealNewDeck: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @trigger 'newDeck', @

  setupEventListeners: ->
    @get('playerHand').on 'bust', =>
      @set 'winner', 'dealer'
      @trigger 'gotWinner', @
    @get('dealerHand').on 'bust', =>
      @set 'winner', 'player'
      @trigger 'gotWinner', @
    @get('playerHand').on 'stand', @callDealerTurn
    @get('dealerHand').on 'stand', =>
      playerScore = @get('playerHand').checkScore()
      dealerScore = @get('dealerHand').checkScore()
      @compareScores playerScore, dealerScore
