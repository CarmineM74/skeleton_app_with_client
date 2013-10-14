'use strict'

angular.module('clientApp')
  .controller 'MainNavCtrl', ($scope,$log,SessionSvc) ->
    $log = $log.getInstance('MainNavCtrl')
    $log.log('Initializing ...')

    $scope.credentials = {email: '', password: ''}
    $scope.logged = false

    $scope.$on('event:authenticated', -> $scope.authenticated())
    $scope.$on('event:unauthorized', -> alert('Unauthorized request!'))

    $scope.login = ->
      $log.log('Login with ' + JSON.stringify($scope.credentials))
      SessionSvc.login($scope.credentials.email,$scope.credentials.password)
      $scope.credentials.password = ''

    $scope.logout = ->
      $log.log('Logging out ...')
      SessionSvc.logout()
      $scope.logged = false
      $scope.credentials = {email: '', password: ''}

    $scope.authenticated = ->
      $scope.logged = true
      $log.log('Login completed: ' + JSON.stringify(SessionSvc.currentUser))
