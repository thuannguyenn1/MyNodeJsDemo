angular.module('eCargoApp.core', []).config(['$routeProvider', '$locationProvider',
  function ($routeProvider, $locationProvider) {
      $routeProvider.otherwise({
            redirectTo: '/products'
        });

  }]);