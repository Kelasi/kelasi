
controllers = angular.module 'kelasi.controllers', []

controllers.controller 'registerStep1Cntl',
  ['registerData',
  (registerData) ->
    @data = registerData
    @w = 1
  ]

controllers.controller 'registerStep2Cntl',
  ['registerData', 'foundUsers',
  (registerData, foundUsers) ->
    @data = registerData
    @users = foundUsers
    @w = 1
  ]

controllers.controller 'registerStep3Cntl',
  ['registerData', '$http'
  (registerData, $http) ->
    @data = registerData
    @save = =>
      $http.post '/api_/users.json', @data.user
    @w = 1
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
