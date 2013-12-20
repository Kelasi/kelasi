
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
  ['$http', '$state'
  ($http, $state) ->
    $http.get('/api_/users').success (data) =>
      @users = data
    @delete_ = (user) =>
      $http.delete("/api_/users/#{user.id}").success (user) =>
        idx = @users.indexOf user
        @users.splice idx, 1
    @profile = (user) ->
      $state.go 'profile', profile_name: user.profile_name
    @w = 1
  ]

controllers.controller 'profileCntl',
  ['profileData',
  (profileData) ->
    @profileData = profileData
    @w = 1
  ]
