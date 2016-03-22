angular.module('eCargoApp.product',[]).factory('productService', ['$http', function ($http) {

    'use strict';
      return {
            getProductsByBrandId : function (brandId, onSuccess, onFail){
                var url = eCargo.globalValues.baseUrl + '/products/' + (brandId == undefined ? '' : brandId) ;
                $http.get(url).then(onSuccess, onFail);
            },
            getReviewByProductId: function (productId, onSuccess, onFail){
                var url = eCargo.globalValues.baseUrl + '/products/' + productId + '/reviews';
                $http.get(url).then(onSuccess, onFail);
            },
            getProductById: function (productId, onSuccess, onFail){
                  var url = eCargo.globalValues.baseUrl + '/product/' + productId;
                  $http.get(url).then(onSuccess, onFail);
            },
            addReview: function (review, onSuccess, onFail){
                var url = eCargo.globalValues.baseUrl + '/products/add';
                $http({
                    method: 'POST',
                    url: url,
                    data: review,
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                }).then(onSuccess, onFail);
            }
      };
}]);