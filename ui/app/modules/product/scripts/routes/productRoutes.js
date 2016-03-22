angular.module('eCargoApp.product').config(['$routeProvider', '$locationProvider',
  function ($routeProvider, $locationProvider) {
      $routeProvider.
        when('/products', {
            templateUrl: '../../../product/html/product.html'
        }).when('/products/:brandId', {
          templateUrl: '../../../product/html/product.html'
        }).when('/product/:productId/details', {
          templateUrl: '../../../product/html/productDetails.html'
        }).otherwise({
          redirectTo: '/products'
        });

  }]);