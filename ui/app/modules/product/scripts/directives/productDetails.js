/**
 * product controller to handle UI.
 */
angular.module('eCargoApp.product').controller('productDetailsController', ['$scope', '$routeParams', 'productService',
    function ($scope, $routeParams, productService) {
        'use strict';
        $scope.reviews =[];
        $scope.productDetails = {};
        $scope.reviewForm = {
            rating: 0,
            comment:'',
            error:[]
        };

        function init() {
            function getReview(productId) {
                productService.getReviewByProductId(productId, function (data) {
                        $scope.reviews = data.data;
                    },
                    angular.noop());
            }

            function getProductDetails(productId){
                productService.getProductById(productId, function (data) {
                        if(data.data.length > 0){
                            $scope.productDetails = data.data[0];
                        }
                    },
                    angular.noop());
            }

            $scope.submitForm = function (form) {

                if (form.$valid) {
                    var postData = {
                        description: form.comment,
                        rating: form.rating,
                        productId:$routeParams.productId,
                        userId: 1
                    };
                    $scope.reviewForm.error =[];
                    productService.addReview(postData, function (data) {
                        $scope.reviews = data.data;
                        $scope.reviewForm.comment ='';
                        $scope.reviewForm.rating = '';
                    }, angular.noop());
                }
            };
            getReview($routeParams.productId);
            getProductDetails($routeParams.productId);
        }

        init();
    }]).directive('productDetails', function(){
    return {

        restrict:'A',
        controller: 'productDetailsController'

    };
}).filter('range', function() {
    return function(input, total) {
        total = parseInt(total);

        for (var i=0; i<total; i++) {
            input.push(i);
        }

        return input;
    };
});