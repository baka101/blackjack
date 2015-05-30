# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @startNewGame()
    @setupChipsModel()
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

  setupChipsModel: ->
    @set 'chips', chips = new ChipsModel()
