assert = chai.assert

describe 'App spec', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'Player Bust', ->
    it 'winner should be set to dealer when player busts', ->
      app.get('game').get('playerHand').cheat 12, 1
      app.get('game').get('playerHand').cheat 12, 1
      assert.strictEqual app.get('game').get('winner'), 'dealer'
  describe 'Dealer Bust', ->
    it 'winner should be set to player when dealer busts', ->
      app.get('game').get('dealerHand').cheat 12, 1
      app.get('game').get('dealerHand').cheat 12, 1
      app.get('game').get('dealerHand').cheat 12, 1
      assert.strictEqual app.get('game').get('winner'), 'player'
    it 'winner should be set to player when dealer busts, bust should be called', ->
      bustSpy = sinon.spy Hand.prototype, 'bust'
      app.get('game').get('playerHand').reset()
      app.get('game').get('playerHand').cheat 4, 0
      app.get('game').get('playerHand').cheat 2, 0
      app.get('game').get('playerHand').cheat 6, 0
      app.get('game').get('playerHand').cheat 9, 0
      app.get('game').get('dealerHand').reset()
      app.get('game').get('dealerHand').cheat 7, 1
      app.get('game').get('dealerHand').cheat 3, 0
      app.get('game').get('dealerHand').cheat 4, 1
      app.get('game').get('dealerHand').cheat 8, 1
      # app.get('game').get('dealerHand').stand()
      assert.strictEqual app.get('game').get('winner'), 'player'
      expect(bustSpy).to.have.been.called
      Hand.prototype.bust.restore()
  describe 'Compare Scores', ->
    it 'On stand, should correctly declare player winner', ->
      app.get('game').get('playerHand').reset()
      app.get('game').get('playerHand').cheat 10, 0
      app.get('game').get('playerHand').cheat 5, 0
      app.get('game').get('playerHand').cheat 6, 0
      app.get('game').get('dealerHand').reset()
      app.get('game').get('dealerHand').cheat 10, 1
      app.get('game').get('dealerHand').cheat 10, 0
      app.get('game').get('dealerHand').stand()
      assert.strictEqual app.get('game').get('winner'), 'player'
    it 'On stand, should correctly declare dealer winner', ->
      app.get('game').get('playerHand').reset()
      app.get('game').get('playerHand').cheat 10, 0
      app.get('game').get('playerHand').cheat 8, 0
      app.get('game').get('dealerHand').reset()
      app.get('game').get('dealerHand').cheat 10, 1
      app.get('game').get('dealerHand').cheat 10, 0
      app.get('game').get('dealerHand').stand()
      assert.strictEqual app.get('game').get('winner'), 'dealer'
    it 'On stand, should correctly declare tie', ->
      app.get('game').get('playerHand').reset()
      app.get('game').get('playerHand').cheat 10, 2
      app.get('game').get('playerHand').cheat 10, 3
      app.get('game').get('dealerHand').reset()
      app.get('game').get('dealerHand').cheat 10, 1
      app.get('game').get('dealerHand').cheat 10, 0
      app.get('game').get('dealerHand').stand()
      assert.strictEqual app.get('game').get('winner'), 'tie'
