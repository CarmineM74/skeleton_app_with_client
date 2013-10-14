'use strict';

angular.module('clientApp')
  .service 'SessionSvc', ($http,$rootScope,$log,$location,$resource) ->
    $log = $log.getInstance('SessionSvc')
    $log.log('Initializing ...')

    setTokenHeaders = (token) ->
      $http.defaults.headers.common['Authorization'] = 'Token ' + token
      $http.defaults.headers.delete = { 'Authorization': 'Token ' + token }

    svc = {
      currentUser: undefined

      login: (email,password) ->
        $log.log('Sending login credentials ...')
        svc.currentUser = {}
        svc.currentUser.email = email
        svc.currentUser.name = 'Hardcoded'
        svc.currentUser.auth_token = 'bigFakeAuthToken1974'
        setTokenHeaders(svc.currentUser.auth_token)
        $rootScope.$broadcast('event:authenticated')

      logout: ->
        $log.log('Logging out ...')
        svc.currentUser = undefined
        setTokenHeaders('EmptyToken')
        $rootScope.$broadcast('event:unauthenticated')

    }

    return svc
