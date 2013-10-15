'use strict'

angular.module('clientApp')
  .controller 'MainNavCtrl', ($scope,$log,$window,SessionSvc) ->
    $log = $log.getInstance('MainNavCtrl')
    $log.log('Initializing ...')

    $scope.credentials = {email: 'test@me.com', password: 'memememe'}
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
      # The following line is commented in order to save
      # the user from credentials input over and over.
      # It MUST BE UNCOMMENTED BEFORE PRODUCTION
      # $scope.credentials = {email: '', password: ''}
      $window.location.href = '/'

    authenticated = ->
      $scope.logged = true
      $log.log('Login completed: ' + JSON.stringify(SessionSvc.currentUser))

    unauthorized = ->
      $scope.logged = false
      $log.log('Redirecting to home page due to unauthorized request')
      $window.location.href = '/'
