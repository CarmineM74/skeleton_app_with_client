'use strict';

angular.module('clientApp')
  .factory 'authInterceptor', ($q,$log,$rootScope) ->

    $log = $log.getInstance('authInterceptor')
    $log.log('Initializing ...')

    interceptor = {
      response: (response) ->
        $log.log('Reponse status: ' + response.status)
        return response || $q.when(response)

      responseError: (rejection) ->
        $log.log('Rejection: ' + JSON.stringify(rejection))
        if rejection.status == 401
          $log.log('Unauthorized')
          $rootScope.$broadcast('event:unauthorized')
        return $q.reject(rejection)
    }

    return interceptor
