assert = chai.assert

describe 'App spec', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'Player Bust', ->
    it 'winner should be set to dealer when player busts', ->
      app.get('playerHand').cheat 12, 1
      app.get('playerHand').cheat 12, 1
      assert.strictEqual app.get('winner'), 'dealer'
  describe 'Dealer Bust', ->
    it 'winner should be set to player when dealer busts', ->
      app.get('dealerHand').cheat 12, 1
      app.get('dealerHand').cheat 12, 1
      assert.strictEqual app.get('winner'), 'player'
  describe 'Compare Scores', ->
    it 'On stand, should correctly declare player winner', ->
      app.get('playerHand').reset()
      app.get('playerHand').cheat 10, 0
      app.get('playerHand').cheat 5, 0
      app.get('playerHand').cheat 6, 0
      app.get('dealerHand').reset()
      app.get('dealerHand').cheat 10, 1
      app.get('dealerHand').cheat 10, 0
      app.get('dealerHand').stand()
      assert.strictEqual app.get('winner'), 'player'
    it 'On stand, should correctly declare dealer winner', ->
      app.get('playerHand').reset()
      app.get('playerHand').cheat 10, 0
      app.get('playerHand').cheat 8, 0
      app.get('dealerHand').reset()
      app.get('dealerHand').cheat 10, 1
      app.get('dealerHand').cheat 10, 0
      app.get('dealerHand').stand()
      assert.strictEqual app.get('winner'), 'dealer'
    it 'On stand, should correctly declare tie', ->
      app.get('playerHand').reset()
      app.get('playerHand').cheat 10, 2
      app.get('playerHand').cheat 10, 3
      app.get('dealerHand').reset()
      app.get('dealerHand').cheat 10, 1
      app.get('dealerHand').cheat 10, 0
      app.get('dealerHand').stand()
      assert.strictEqual app.get('winner'), 'tie'
