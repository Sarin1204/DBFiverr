/**
 * Created by starn on 4/28/2016.
 */
angular.module('category').controller('CategoryController',['$scope',
    '$routeParams', '$location','Category',
    function($scope, $routeParams, $location, Category){
        console.log("getCategory"+JSON.stringify(getCategory.category))
        Category.getCategory.get(function(response){
            console.log('allCategories are '+JSON.stringify(response));
            $scope.getCategory = response.all_category;
        }, function(error){
            console.log('Inside error for allCategories');
            $scope.errorMsg = 'Oops! Something unexpected occured!'
        });

    }
]);
