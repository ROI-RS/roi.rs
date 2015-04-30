---
---

ROI = angular.module 'ROI', ['duScroll'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

ROI.value 'duScrollGreedy', true
ROI.value 'duScrollDuration', 2000

ROI.controller 'WelcomeCtrl', ['$scope', '$window', ($scope, $window)->
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

ROI.controller 'ContactFormCtrl', ['$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  $scope.message =
    form: 0
    config: 28
    callback: 'JSON_CALLBACK'
    token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent(get_cookie 'sbjs_current')}"
    $http.jsonp("http://umark.realto.be/?#{url}").success (uid)->
      $scope.set('busy', false)
      $scope.set('showConnect', false)
      $scope.set('showThankYou', true)
      $timeout ->
        $scope.set('showThankYou', false)
      , 3000
]

ROI.controller 'LoginFormCtrl', ['$scope', ($scope)->
  $scope.login = {}
  $scope.send = ->
]