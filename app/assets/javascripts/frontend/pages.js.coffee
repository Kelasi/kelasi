# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require 'angular-ui-router'

kelasi = angular.module 'kelasi', ['ui.router', 'kelasi.controllers']

kelasi.config ['$stateProvider', '$urlRouterProvider', '$locationProvider',
  ($stateProvider, $urlRouterProvider, $locationProvider) ->

    $locationProvider.html5Mode on

    $urlRouterProvider.otherwise '/home'

    $stateProvider
      .state('home',
        url: '/home'
        templateUrl: '/fe_/home'
      ).state('admin',
        url: '/admin'
        templateUrl: '/fe_/admin'
      ).state('admin.users',
        url: '/users'
        templateUrl: '/fe_/admin/users'
        controller: 'adminUsersCntl'
      ).state('register',
        abstract: true
        url: '/register'
        templateUrl: '/fe_/register'
        resolve:
          registerData: -> {}
      ).state('register.step1',
        url: '/step1'
        templateUrl: '/fe_/register/step1'
        controller: 'registerStep1Cntl as cntl'
      ).state('register.step2',
        url: '/step2'
        templateUrl: '/fe_/register/step2'
        controller: 'registerStep2Cntl as cntl'
        resolve:
          foundUsers: ['registerData', '$http', '$q'
            (data, $http, $q) ->
              d = $q.defer()
              $http.post('/api_/search', data.search)
                .success (data) -> d.resolve data
              d.promise
          ]
      ).state('register.step3',
        url: '/step3'
        templateUrl: '/fe_/register/step3'
        controller: 'registerStep3Cntl as cntl'
      )
]
