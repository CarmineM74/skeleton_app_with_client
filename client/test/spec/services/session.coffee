'use strict'

describe 'Service: session', () ->

  # load the service's module
  beforeEach module 'clientApp'

  # instantiate service
  session = {}
  beforeEach inject (_session_) ->
    session = _session_

  it 'should do something', () ->
    expect(!!session).toBe true
