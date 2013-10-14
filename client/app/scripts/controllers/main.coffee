'use strict'

angular.module('clientApp')
  .controller 'MainCtrl', ($scope,$log) ->
    $log = $log.getInstance('MainCtrl')
    $log.log('Initializing ...')

    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
