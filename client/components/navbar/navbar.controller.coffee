'use strict'

angular.module('syncboardApp').controller 'NavbarCtrl', ($scope, $location) ->
  $scope.menu = [
    {title: 'Home'
    link: '/'}
    {
      title: 'Board'
      link: '/board'
    }
  ]
  $scope.isCollapsed = true

  $scope.isActive = (route) ->
    route is $location.path()
