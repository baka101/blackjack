assert = chai.assert

describe 'hand collection spec', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49
  describe 'bust', ->
    it 'should bust when score is over 21', ->
      bustSpy = sinon.spy Hand.prototype,'bust'
      hand.cheat 12, 1
      hand.cheat 12, 1
      expect(bustSpy).to.have.been.called
  describe 'dealerStand', ->
    it 'should stand when the score is between 17 and 21', ->
      standSpy = sinon.spy Hand.prototype, 'stand'
      hand.reset()
      hand.cheat 12, 1
      hand.cheat 9, 1
      hand.dealerTurn()
      expect(standSpy).to.have.been.called

