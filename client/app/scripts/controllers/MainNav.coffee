'use strict'

angular.module('clientApp')
  .controller 'MainNavCtrl', ($scope,$log,$window,SessionSvc) ->
    $log = $log.getInstance('MainNavCtrl')
    $log.log('Initializing ...')

    $scope.credentials = {email: '', password: ''}
    $scope.logged = false

    $scope.$on('event:authenticated', -> authenticated())
    $scope.$on('event:unauthorized', -> unauthorized())

    $scope.login = ->
      $log.log('Login with ' + JSON.stringify($scope.credentials))
      SessionSvc.login($scope.credentials.email,$scope.credentials.password)
      $scope.credentials.password = ''

    $scope.logout = ->
      $log.log('Logging out ...')
      SessionSvc.logout()
      $scope.logged = false
      $scope.credentials = {email: '', password: ''}

    authenticated = ->
      $scope.logged = true
      $log.log('Login completed: ' + JSON.stringify(SessionSvc.currentUser))

    unauthorized = ->
      $scope.logged = false
      $log.log('Redirecting to home page due to unauthorized request')
      $window.location.href = '/'
