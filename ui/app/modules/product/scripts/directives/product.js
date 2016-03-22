angular.module('eCargoApp.product').controller('productController', ['$scope', '$routeParams', 'productService',
    function ($scope, $routeParams, productService) {
        'use strict';
    $scope.productGroup =[];
    function init() {
        productService.getProductsByBrandId($routeParams.brandId, function(data){
           $scope.productGroup = standardizeData(data.data);
        },
        angular.noop());

        function standardizeData(data){
            if(!data){
                return;
            }
            var i,
                numbderOfColumn = eCargo.globalValues.itemColumn,
                newData = [],
                tempArray = [],
                arrayLength =  data.length;
            for(i = 0; i < arrayLength; i+=numbderOfColumn){
                tempArray = data.slice(i, i+numbderOfColumn);
                newData.push(tempArray);
            }
            return newData;
        };
    }

        init();
}]).directive('productItems', function () {
    return {

        restrict:'E',
        templateUrl: '../../../product/html/productItems.html',
        controller: 'productController'

    };
});