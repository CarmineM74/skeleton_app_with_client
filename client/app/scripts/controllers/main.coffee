'use strict'

angular.module('clientApp')
  .controller 'MainCtrl', ($scope,$log,UsersSvc,SessionSvc) ->
    $log = $log.getInstance('MainCtrl')
    $log.log('Initializing ...')

    $scope.$on('event:users:index-success', (e,data) -> indexSuccess(data))
    $scope.$on('event:users:delete-success', -> deleteSuccess())
    $scope.$on('event:users:delete-failed', (e,resp) -> deleteFailed(resp))

    $scope.users = []

    $scope.getUsers = ->
      UsersSvc.index()

    indexSuccess = (data) ->
      $log.log('Received users: ' + JSON.stringify(data))
      $scope.users = data

    $scope.deleteUser = (u) ->
      $log.log('Deleting user: ' + JSON.stringify(u))
      UsersSvc.delete(u)

    deleteSuccess = ->
      $log.log('DELETED')
      UsersSvc.index()

    deleteFailed = (resp) ->
      $log.log('FAILED: ' + JSON.stringify(resp))

    $scope.isCurrentUser = (u) ->
      angular.equals(u,SessionSvc.currentUser)


