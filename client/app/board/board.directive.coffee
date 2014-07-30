'use strict'

angular.module('syncboardApp').directive 'board', ($timeout) ->
  scope: {figures:'=',tool:'@',paperStyle:'='}
  restrict: 'A'
  link: ($scope, $element, $attrs) ->
    initialBoard = ()->
      canvas = $element[0]
      $scope.paper = new paper.PaperScope();
      $scope.paper.setup(canvas);
      $scope.paper.project.activeLayer.removeChildren()

      tool = new $scope.paper.Tool()

      newPath = null
      tool.onMouseDown = (event)->
        switch $scope.tool
          when 'pen'
            newPath = new $scope.paper.Path()
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
            newPath.add(event.point)
          when 'eraser'
            newPath = new $scope.paper.Path()
            newPath.strokeColor = 'white'
            newPath.strokeWidth = 50
            newPath.add(event.point)
          when 'line'
            newPath = new $scope.paper.Path()
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
            newPath.add(event.point)
            newPath.add(event.point)
          when 'circle'
            newPath = new $scope.paper.Path.Circle(event.point, 20)
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
          when 'rectangle'
            newPath = new $scope.paper.Path.Rectangle(event.point, event.point)
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
          when 'text'
            console.log 'text'

      tool.onMouseDrag = (event)->
        switch $scope.tool
          when 'pen'
            newPath.add(event.point)
          when 'eraser'
            newPath.add(event.point)
          when 'line'
            newPath.remove()
            newPath = new $scope.paper.Path()
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
            newPath.add(event.downPoint)
            newPath.add(event.point)
          when 'circle'
            newPath.remove()
            if $scope.paper.Key.isDown('shift')
              rectangle = new $scope.paper.Rectangle(event.downPoint,new $scope.paper.Size(event.point.x - event.downPoint.x,event.point.y - event.downPoint.y))
              newPath = new $scope.paper.Path.Circle(new $scope.paper.Point((event.point.x + event.downPoint.x) / 2, (event.point.y + event.downPoint.y) / 2),event.point.getDistance(event.downPoint) / 2)
            else
              rectangle = new $scope.paper.Rectangle(event.downPoint,new $scope.paper.Size(event.point.x - event.downPoint.x,event.point.y - event.downPoint.y))
              newPath = new $scope.paper.Path.Ellipse(rectangle)
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
          when 'rectangle'
            newPath.remove()
            newPath = new $scope.paper.Path.Rectangle(event.downPoint,event.point)
            newPath.strokeColor = $scope.paperStyle.strokeColor or 'black'
            newPath.strokeWidth = $scope.paperStyle.strokeWidth or 1
          when 'text'
            console.log 'text'


      tool.onMouseUp = (event)->
        switch $scope.tool
          when 'pen'
            newPath.smooth()
            newPath.simplify()
          when 'line'
            console.log newPath
        $scope.$emit 'draw',newPath.exportJSON()

      # Draw the view now:
      $scope.paper.view.draw()

    initialBoard()

    draw = (figures)->
      initialBoard()
      for figure in figures
        do (figure)->
            path = new $scope.paper.Path()
            path.importJSON(figure.data)
      $scope.paper.view.draw()

    $scope.$watch 'figures', (newValue)->
      if not newValue
        return
      draw(newValue)

    , true


