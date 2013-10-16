'use strict'

angular.module('clientApp', ['ngRoute','ngResource','decorators'])
  .config ($routeProvider,$httpProvider) ->
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    $httpProvider.interceptors.push('authInterceptor')
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/signup',
        templateUrl: 'views/users/create.html'
        controller: 'NewUserCtrl'
      .otherwise
        redirectTo: '/'
