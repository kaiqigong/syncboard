'use strict'

angular.module('syncboardApp').controller 'BoardCtrl', ($scope,$http,socket) ->
  $scope.message = 'Hello'
  $scope.tool = 'pen'
  $scope.style = {strokeWidth:1,strokeColor:'#000000'}
  $scope.$on 'draw',(event, newFigure)->
    # socket.emit 'draw',{data:newFigure}
    $http.post('/api/figures',{data:newFigure})

  $http.get('/api/figures').success (figures) ->
    $scope.figures = figures
    socket.syncUpdates 'figure', $scope.figures

  $scope.undo = ()->
    last = $scope.figures.pop()
    if last
      $http.delete('/api/figures/' + last._id)

  $scope.reset = ()->
    last = $scope.figures.pop()
    while last
      $http.delete('/api/figures/' + last._id)
      last = $scope.figures.pop()



