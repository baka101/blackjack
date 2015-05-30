class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'add', @checkBust

  hit: ->
    card = @deck.pop()
    @add(card)
    card

  stand: ->
    @trigger 'stand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  checkBust: ->
    # lowestScore = Math.min.apply null, @scores()

    if @checkScore() > 21
      @bust()

  bust: ->
    @trigger 'bust'

  dealerTurn: ->

    if not @at(0).get 'revealed'
      @at(0).flip()

    @hit() while @checkScore() < 17

    if @checkScore() >= 17 and @checkScore() <= 21
      @stand()

    else if @checkScore() > 21
      @bust()

  checkScore: ->
    if (Math.max.apply null, @scores()) <= 21
      Math.max.apply null, @scores()
    else
      Math.min.apply null, @scores()

  cheat: (rank, suit) ->
    card = new Card rank: rank, suit: suit
    @add(card)
