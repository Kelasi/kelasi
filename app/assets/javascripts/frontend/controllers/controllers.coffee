
controllers = angular.module 'kelasi.controllers', []

controllers.controller 'registerStep1Cntl',
  ['$scope', '$http', '$state', 'registerData',
  ($scope, $http, $state, registerData) ->
    data = $scope.data = registerData
    $scope.search = ->
      fname = $scope.fname
      lname = $scope.lname
      uniname = $scope.uniname
      $http.post('/api_/search', {fname: fname, lname: lname, university: uniname})
        .success (r) ->
          data.users = r
          $state.go 'register.step2'
  ]

controllers.controller 'registerStep2Cntl',
  ['$scope', '$state', 'registerData',
  ($scope, $state, registerData) ->
    data = $scope.data = registerData
  ]

controllers.controller 'registerStep3Cntl',
  ['$scope', '$state', 'registerData',
  ($scope, $state, registerData) ->
    data = $scope.data = registerData
  ]

controllers.controller 'adminUsersCntl',
  ['$scope', '$http',
  ($scope, $http) ->
    $http.get('/api_/users').success (data) ->
      $scope.users = data
    $scope.delete_ = (user) ->
      $http.delete("/api_/users/#{user.id}").success (user) ->
        idx = $scope.users.indexOf user
        $scope.users.splice idx, 1
  ]
