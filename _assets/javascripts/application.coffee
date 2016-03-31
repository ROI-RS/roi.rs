#= require vendor/angular/angular.min
#= require vendor/angular-animate/angular-animate.min
#= require vendor/angular-scroll/angular-scroll.min
#= require vendor/ngMask/dist/ngMask.min

ROI = angular.module 'ROI', ['duScroll', 'ngAnimate', 'ngMask'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('/*')
  $interpolateProvider.endSymbol('/*')

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
  $scope.confThankYou = false
  $scope.showMedForm = false
  $scope.medConfThankYou = false
  $scope.busy = false
  $scope.get = (name)-> $scope[name]
  $scope.set = (name, state)-> $scope[name] = state
  
  offset = $window.innerHeight
  $scope.getOffset = (plus = 0)-> offset + plus - 25
  
  $scope.getCookie = (name)->
    matches = document.cookie.match(new RegExp(
      "(?:^|; )#{name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1')}=([^;]*)"
    ))
    if matches then decodeURIComponent(matches[1]) else undefined
  $scope.displayConnect = () ->
    $scope.showConnect = !$scope.showConnect
    ga 'send',
      hitType: 'event'
      eventCategory: 'forms'
      eventAction: 'open_form'
    yaCounter30093989.reachGoal('open_form')
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
      agency: false
  
  $scope.setMessage()
  $scope.focused = null
  
  $scope.makeFocused = (field)->
    $scope.focused = field
    
  $scope.resetFocused = ()->
    $scope.focused = null
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent($scope.getCookie('sbjs_current'))}"
    $http.jsonp("https://umarker.roi.rs/?#{url}").success (uid)->
      ga 'send',
        hitType: 'event'
        eventCategory: 'forms'
        eventAction: 'send_form'
      yaCounter30093989.reachGoal('send_form')
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
      form: 'conference'
      config: 28
      callback: 'JSON_CALLBACK'
      token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.setMessage()
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent($scope.getCookie('sbjs_current'))}"
    $http.jsonp("https://umarker.roi.rs/?#{url}").success (uid)->
      $scope.setMessage()
      $scope.set('busy', false)
      $scope.set('confThankYou', true)
]

ROI.controller 'MedConfFormCtrl', ['$scope', '$http', '$timeout', '$location', ($scope, $http, $timeout, $location)->
  medConf = angular.element document.getElementById('med-conf')
  leftSide = angular.element document.getElementById('left-side')
  rightSide = angular.element document.getElementById('right-side')
  program = angular.element document.getElementById('program')
  test = document.body.offsetWidth > 1024
  
  if $location.path() == '/form' then $scope.set('showMedForm', true)
  if $location.path() == '/program' then (if test then rightSide else medConf).duScrollToElementAnimated program, if test then 50 else 25
  
  $scope.setMessage = ->
    $scope.message =
      form: 'med_conference'
      config: 28
      callback: 'JSON_CALLBACK'
      token: 'nQ7LBMohbPwy1tjLIw'
  
  $scope.setMessage()
  
  $scope.send = (msg)->
    $scope.set('busy', true)
    url = ""
    for field, value of msg then url += "#{field}=#{encodeURIComponent(value)}&"
    url += "sbjs_current=#{encodeURIComponent($scope.getCookie('sbjs_current'))}"
    $http.jsonp("https://umarker.roi.rs/?#{url}").success (uid)->
      $scope.setMessage()
      $scope.set('busy', false)
      $scope.set('medConfThankYou', true)
      test = document.body.offsetWidth > 1024
      (if test then leftSide else medConf).scrollTopAnimated 0
      $timeout ->
        $scope.set('showMedForm', false)
        $scope.set('medConfThankYou', false)
      , 3000
  
  $scope.scrollTop = ->
    test = document.body.offsetWidth > 1024
    (if test then leftSide else medConf).scrollTopAnimated 0, 300
]

ROI.controller 'LoginFormCtrl', ['$scope', '$timeout', ($scope, $timeout)->
  $scope.login = {}
  $scope.send = ->
    $scope.set('busy', true)
    $timeout ->
      $scope.set('busy', false)
    , 3000
    
]