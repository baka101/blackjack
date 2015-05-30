class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="deal-button">Deal Again, Jerk!</button>
    <div class="winner-box"></div>
    <div class="chips"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .deal-button': ->
      @model.startNewGame()
      @setupEventListeners()
      @render()

  initialize: ->
    @setupEventListeners()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el
    @$('.chips').html new ChipsView(model: @model.get 'chips').el

  handleWinner: ->
    @$('.hit-button').hide()
    @$('.stand-button').hide()
    @showWinner()

  showWinner: ->
    winnerName = @model.get('game').get "winner"
    console.log "The #{winnerName} has won"
    if winnerName == "tie"
      @$('.winner-box').html "<h1>It's a tie... Cry me a river.</h1>"
    else if winnerName == "player"
      @$('.winner-box').html "<h1>Hey you won! Go start a band.</h1>"
    else if winnerName == "dealer"
      @$('.winner-box').html "<h1>You got served. Play again.</h1>"

  setupEventListeners: ->
    @model.get('game').on 'gotWinner', @handleWinner, @
