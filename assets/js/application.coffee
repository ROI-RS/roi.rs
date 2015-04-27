---
---

ROI = angular.module 'ROI', ['duScroll'], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

ROI.value 'duScrollBottomSpy', true