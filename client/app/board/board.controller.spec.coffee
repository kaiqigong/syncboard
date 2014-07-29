'use strict'

describe 'Controller: BoardCtrl', ->

  # load the controller's module
  beforeEach module('syncboardApp')
  BoardCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject(($controller, $rootScope) ->
    scope = $rootScope.$new()
    BoardCtrl = $controller('BoardCtrl',
      $scope: scope
    )
  )
  it 'should ...', ->
    expect(1).toEqual 1
