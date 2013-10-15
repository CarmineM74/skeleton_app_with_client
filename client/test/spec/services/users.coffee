'use strict'

describe 'Service: users', () ->

  # load the service's module
  beforeEach module 'clientApp'

  # instantiate service
  users = {}
  beforeEach inject (_users_) ->
    users = _users_

  it 'should do something', () ->
    expect(!!users).toBe true
