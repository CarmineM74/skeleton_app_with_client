'use strict'

describe 'Controller: MainnavCtrl', () ->

  # load the controller's module
  beforeEach module 'clientApp'

  MainnavCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainnavCtrl = $controller 'MainnavCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
