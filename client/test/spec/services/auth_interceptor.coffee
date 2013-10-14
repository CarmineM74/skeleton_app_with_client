'use strict'

describe 'Service: authInterceptor', () ->

  # load the service's module
  beforeEach module 'clientApp'

  # instantiate service
  authInterceptor = {}
  beforeEach inject (_authInterceptor_) ->
    authInterceptor = _authInterceptor_

  it 'should do something', () ->
    expect(!!authInterceptor).toBe true
