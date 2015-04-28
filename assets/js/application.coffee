---
---

ROI = angular.module 'ROI', ['duScroll'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

ROI.value 'duScrollOffset', 400
ROI.value 'duScrollGreedy', true

ROI.controller 'WelcomeCtrl', ['$scope', ($scope)->
  $scope.whyClicksGoDown = false
  $scope.whyBudgetGoDown = false
  $scope.whyCommunicationsGoDown = false
  $scope.toggle = (name, state)-> $scope[name] = state
]

ROI.controller 'ContactFormCtrl', ['$scope', '$http', ($scope, $http)->
  $scope.message =
    form: 0
    config: 28
    callback: 'JSON_CALLBACK'
    token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.send = (msg)->
    url = ""
    
    for field, value of msg
      url += "#{field}=#{encodeURIComponent(value)}&"

    url += "sbjs_current=#{encodeURIComponent(get_cookie 'sbjs_current')}"

    $http.jsonp("http://umark.realto.be/?#{url}").success((uid)->
      $scope.$parent.$parent.showConnect = false
      alert "Form number #{uid} has been delivered"
    )
    
]