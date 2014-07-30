'use strict'

angular.module('syncboardApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.bootstrap',
  'btford.socket-io',
  'ui.router',
  'colorpicker.module'
])
  .config (($stateProvider, $urlRouterProvider, $locationProvider) ->
    $urlRouterProvider
    .otherwise('/')

    $locationProvider.html5Mode true
  )
