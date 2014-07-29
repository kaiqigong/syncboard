'use strict'

angular.module('syncboardApp').controller 'BoardCtrl', ($scope,$http) ->

  $scope.figures = []

  $scope.$on 'draw',(event, newFigure)->
    console.log newFigure
    $http.post('/api/figures',newFigure)

  $http.get('/api/figures').success (figures) ->
    $scope.figures = figures
    socket.syncUpdates 'figures', $scope.figures

