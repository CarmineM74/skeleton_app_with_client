'use strict'

describe 'Directive: pwCheck', () ->

  # load the directive's module
  beforeEach module 'clientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pw-check></pw-check>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pwCheck directive'
