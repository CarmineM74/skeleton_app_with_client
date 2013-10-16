'use strict'

angular.module('clientApp')
  .controller 'NewUserCtrl', ($scope,$log) ->
    $log = $log.getInstance('NewUserCtrl')
    $log.log('Initializing ...')

    $scope.user = {}
