'use strict'

angular.module('clientApp')
  .controller 'NewUserCtrl', ($scope,$log,UsersSvc) ->
    $log = $log.getInstance('NewUserCtrl')
    $log.log('Initializing ...')

    $scope.$on('event:users:create-success',-> userCreated())
    $scope.$on('event:users:create-failed', (e,resp) -> userNotCreated(resp))

    $scope.user = {
      name: ''
      email: ''
      password: ''
      password_confirmation: ''
    }

    $scope.createUser = ->
      $log.log('Creating new user ...')
      UsersSvc.save($scope.user)

    userCreated = ->
      $log.log('Success')
      alert('New user created!')

    userNotCreated = (resp) ->
      $log.log('Failed: ' + JSON.stringify(resp))
      alert('User could not be created: ' + resp.info)
