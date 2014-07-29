'use strict'

angular.module('syncboardApp').config ($stateProvider) ->
  $stateProvider.state 'board',
    url: '/board'
    templateUrl: 'app/board/board.html'
    controller: 'BoardCtrl'
