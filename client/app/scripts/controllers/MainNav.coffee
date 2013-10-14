'use strict'

angular.module('clientApp')
  .controller 'MainNavCtrl', ($scope,$log) ->
    $log = $log.getInstance('MainNavCtrl')
    $log.log('Initializing ...')

    $scope.credentials = {email: '', password: ''}
    $scope.logged = false

    $scope.login = ->
      $log.log('Login with ' + JSON.stringify($scope.credentials))
      $scope.logged = true
      $scope.credentials.password = ''

    $scope.logout = ->
      $log.log('Logging out ...')
      $scope.logged = false
      $scope.credentials = {email: '', password: ''}
