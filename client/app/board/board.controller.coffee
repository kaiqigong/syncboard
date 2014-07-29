'use strict'

angular.module('syncboardApp').controller 'BoardCtrl', ($scope) ->
  $scope.message = 'Hello'
  angular.extend $scope,
    addPath: ()->
      console.log 'add'
    figures: [
      {
        type:'path'
        strokeColor:'red'
        strokeWidht:1
        points:[
          {
            x:50
            y:100
          }
          {
            x:62
            y:120
          }
          {
            x:80
            y:140
          }
          {
            x:150
            y:160
          }
        ]
      }
      {
        type:'path'
        strokeColor:'black'
        strokeWidht:1
        points:[
          {
            x:0
            y:0
          }
          {
            x:80
            y:120
          }
          {
            x:100
            y:140
          }
          {
            x:200
            y:150
          }
        ]
      }
    ]
