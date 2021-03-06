'use strict';

angular.module('clientApp')
  .service 'SessionSvc', ($http,$rootScope,$log,$location,$resource) ->
    $log = $log.getInstance('SessionSvc')
    $log.log('Initializing ...')

    session = $resource('/api/session')

    setTokenHeaders = (token) ->
      $http.defaults.headers.common['Authorization'] = 'Token ' + token
      $http.defaults.headers.delete = { 'Authorization': 'Token ' + token }

    svc = {
      currentUser: undefined

      isLogged: ->
        if svc.currentUser?
          true
        else
          false

      login: (email,password) ->
        $log.log('Sending login credentials ...')
        session.save({user: {email: email, password: password}},
          (response) ->
            $log.log('Login successful!')
            svc.currentUser = response.data
            setTokenHeaders(svc.currentUser.auth_token)
            $rootScope.$broadcast('event:authenticated')
          ,(response) ->
            $log.log('Login failed!')
            svc.currentUser = undefined
            setTokenHeaders('')
            if response.status == 404
              alert(response.data.info)
        )

      logout: ->
        $log.log('Logging out ...')
        session.delete(
          (response) ->
            $log.log('Logout completed')
          ,(response) ->
            $log.log('Logout error: ' + response.info)
        )
        svc.currentUser = undefined
        setTokenHeaders('')
        $rootScope.$broadcast('event:unauthorized')

    }
    
    $rootScope.isLogged = svc.isLogged

    return svc
