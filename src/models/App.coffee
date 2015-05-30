# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @startNewGame()
    @setupChipsModel()
    @setupEventListeners()
    # @get('playerHand').on 'bust', =>
    #   @set 'winner', 'dealer'
    # @get('dealerHand').on 'bust', =>
    #   @set 'winner', 'player'
    # @get('playerHand').on 'stand', @callDealerTurn
    # @get('dealerHand').on 'stand', =>
    #   playerScore = @get('playerHand').checkScore()
    #   dealerScore = @get('dealerHand').checkScore()
    #   @compareScores playerScore, dealerScore

  startNewGame: ->
    @set 'game', game = new GameModel()
    @setupEventListeners()

  setupChipsModel: ->
    @set 'chips', chips = new ChipsModel()

  settleChips: ->

    winnerName = @get('game').get('winner')

    if winnerName == 'player'
      @get('chips').playerWin()
    else if winnerName == 'dealer'
      @get('chips').dealerWin()
    else if winnerName == 'tie'
      @get('chips').tie()

  setupEventListeners: ->
    @get('game').on 'gotWinner', @settleChips, @
