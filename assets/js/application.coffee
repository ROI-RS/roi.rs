---
---

ROI = angular.module 'ROI', ['duScroll', 'ngAnimate'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

ROI.value 'duScrollGreedy', true
ROI.value 'duScrollDuration', 2000

ROI.controller 'WelcomeCtrl', ['$scope', '$window', ($scope, $window)->
  $scope.active = true
  $scope.whyClicksGoDown = false
  $scope.whyBudgetGoDown = false
  $scope.whyCommunicationsGoDown = false
  $scope.showLogin = false
  $scope.showConnect = false
  $scope.showThankYou = false
  $scope.busy = false
  $scope.get = (name)-> $scope[name]
  $scope.set = (name, state)-> $scope[name] = state
  
  offset = $window.innerHeight
  $scope.getOffset = (plus = 0)-> offset + plus - 25
]

ROI.directive 'clickOutsideOrClose', ['$document', '$timeout', ($document, $timeout)->
  scope:
    fn: '&clickOutsideOrClose'
  
  link: (scope, element)->
    close = element.find('a')
    
    $timeout ->
      $document.bind 'click', (event)->
        isClickedElementChildOfPopup = element[0].contains event.target
        isClickedElementCloseOfPopup = close[0].contains event.target
        if !isClickedElementChildOfPopup || isClickedElementCloseOfPopup
          $document.unbind 'click'
          scope.$apply scope.fn()
]
    

ROI.controller 'ContactFormCtrl', ['$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  $scope.setMessage = ->
    $scope.message =
      form: 'registration'
      config: 28
      callback: 'JSON_CALLBACK'
      token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.setMessage()
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent(get_cookie 'sbjs_current')}"
    $http.jsonp("https://umarker.roi.rs/?#{url}").success (uid)->
      $scope.setMessage()
      $scope.set('busy', false)
      $scope.set('showConnect', false)
      $scope.set('showThankYou', true)
      $timeout ->
        $scope.set('showThankYou', false)
      , 3000
]


ROI.controller 'ConfFormCtrl', ['$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  $scope.setMessage = ->
    $scope.message =
      form: 0
      config: 28
      callback: 'JSON_CALLBACK'
      token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.setMessage()
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent(get_cookie 'sbjs_current')}"
    $http.jsonp("http://umark.realto.be/?#{url}").success (uid)->
      $scope.setMessage()
      $scope.set('busy', false)
]

ROI.controller 'LoginFormCtrl', ['$scope', '$timeout', ($scope, $timeout)->
  $scope.login = {}
  $scope.send = ->
    $scope.set('busy', true)
    $timeout ->
      $scope.set('busy', false)
    , 3000
    
]