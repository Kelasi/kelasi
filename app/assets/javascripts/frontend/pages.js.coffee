# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require 'angular-ui-router'

kelasi = angular.module 'kelasi', ['ui.router']

kelasi.config ['$httpProvider', '$stateProvider', '$urlRouterProvider', '$locationProvider',
  ($httpProvider, $stateProvider, $urlRouterProvider, $locationProvider) ->

    token = $("meta[name='csrf-token']").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-Token"] = token
    $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest'

    $locationProvider.html5Mode on

    $urlRouterProvider.otherwise '/home'

    $stateProvider
      .state('home',
        url: '/home',
        template: 'HOME'
      ).state('admin',
        url: '/admin',
        template: '<h1>Admin</h1><ui-view></ui-view>'
      ).state('admin.users',
        url: '/users',
        templateUrl: '/fe_/user_management'
      ).state('register',
        url: '/register',
        templateUrl: '/fe_/register'
      )
]
