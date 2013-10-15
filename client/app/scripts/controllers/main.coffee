'use strict'

angular.module('clientApp')
  .controller 'MainCtrl', ($scope,$log,UsersSvc) ->
    $log = $log.getInstance('MainCtrl')
    $log.log('Initializing ...')

    $scope.$on('event:users:index-success', (e,data) -> indexSuccess(data))

    $scope.users = []

    $scope.getUsers = ->
      UsersSvc.index()

    indexSuccess = (data) ->
      $log.log('Received users: ' + JSON.stringify(data))
      $scope.users = data
