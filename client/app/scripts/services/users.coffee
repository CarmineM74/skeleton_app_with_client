'use strict';

angular.module('clientApp')
  .service 'UsersSvc', ($rootScope,$log,$resource) ->
    $log = $log.getInstance('UsersSvc')
    $log.log('Initializing ...')

    users = $resource('/api/users/:id')

    svc = {
      index: ->
        users.query(
          (response) ->
            $log.log('Index success')
            $rootScope.$broadcast('event:users:index-success',response)
          ,(response) ->
            $log.log('Index failed: ' + JSON.stringify(response))
            $rootScope.$broadcast('event:users:index-failed')
        )
    }

    return svc
