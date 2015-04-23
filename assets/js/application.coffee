---
---

ROI = angular.module 'ROI', ['gilbox.sparkScroll'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

ROI.directive 'sticky', ['$window', ($window)->
  link: (scope, element, attrs)->
    element[0].style.position = '-webkit-sticky'
    if element[0].style.position != '-webkit-sticky'
      element[0].style.position = 'sticky'
      if element[0].style.position != 'sticky'
        window = angular.element $window
        setElement = -> element[0].style.top = $window.pageYOffset + 'px'
        window.on 'scroll', (event)-> setElement()
        window.on 'resize', (event)-> setElement()
        setElement()
]

ROI.directive 'fullHeight', ['$window', ($window)->
  link: (scope, element, attrs)->
    window = angular.element $window
    setElement = -> element[0].style.height = $window.innerHeight + 'px'
    window.on 'resize', (event)-> setElement()
    setElement()
]