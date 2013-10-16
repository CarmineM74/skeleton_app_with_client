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
      
      save: (user) ->
        if !user.id?
          $log.log('Creating ...')
          users.save({user: user},
            (response) ->
              $log.log('Success')
              $rootScope.$broadcast('event:users:create-success')
            ,(response) ->
              $log.log('Failed: ' + JSON.stringify(response))
              $rootScope.$broadcast('event:users:create-failed',response.data)
          )
        else
          $log.log('Updating ...')

    }

    return svc
