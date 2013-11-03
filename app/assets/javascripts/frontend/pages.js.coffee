# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require 'angular-ui-router'

kelasi = angular.module 'kelasi', ['ui.router']

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
      ).state('register',
        url: '/register'
        templateUrl: '/fe_/register'
      ).state('register.step1',
        url: '/step1'
        templateUrl: '/fe_/register/step1'
      )
]
