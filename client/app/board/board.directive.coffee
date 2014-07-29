'use strict'

angular.module('syncboardApp').directive 'board', ($timeout) ->
  scope: {figures:'='}
  restrict: 'A'
  link: ($scope, $element, $attrs) ->
    initialBoard = ()->
      canvas = $element[0]
      $scope.paper = new paper.PaperScope();
      $scope.paper.setup(canvas);
      $scope.paper.project.activeLayer.removeChildren()

      tool = new $scope.paper.Tool()

      newFigure = null
      newPath = null
      tool.onMouseDown = (event)->
        console.log event
        newFigure = {}
        newFigure.type = 'path'
        newFigure.strokeColor = 'black'
        newFigure.strokeWidth = 1
        newFigure.points = []
        newFigure.points.push({x:event.point.x,y:event.point.y})

        newPath = new $scope.paper.Path()
        newPath.strokeColor = 'black'
        newPath.strokeWidth = 1
        newPath.add(event.point)

      tool.onMouseDrag = (event)->
        newFigure.points.push({x:event.point.x,y:event.point.y})

        newPath.add(event.point)

      tool.onMouseUp = (event)->
        $scope.$emit 'draw',newFigure
        $scope.figures.push newFigure
        draw($scope.figures)

      # Draw the view now:
      $scope.paper.view.draw()

    initialBoard()

    draw = (figures)->
      initialBoard()
      for figure in figures
        do (figure)->
          switch figure.type
            when 'path'
              path = new $scope.paper.Path()
              path.strokeColor = figure.strokeColor or 'black'
              path.strokeWidth = figure.strokeWidth or 1
              for point in figure.points
                path.add(new $scope.paper.Point(point.x, point.y))
              console.log path
      $scope.paper.view.draw()

    $scope.$watch 'figures', (newValue)->
      if not newValue
        return
      draw(newValue)

    , true


