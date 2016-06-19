/**
 * Created by ramyavarakantham on 4/29/2016.
 */

angular.module('insertnewrequest').controller('NewRequestController',['$scope',
    '$routeParams', '$location','insertNewRequest',
    function($scope, $routeParams, $location, insertNewRequest){

        $scope.insert_newrequest = function(){
            console.log('Inside creating new request');
            var newrequest = new insertNewRequest.insertnewrequest({
                title: this.title,
                description: this.description,
                days_to_complete: this.days_to_complete,
                category_name: this.category_name
            });

            console.log('new request is'+JSON.stringify(newrequest));

            newrequest.$save(function(response){
                /*$window.location.href='http://localhost:3000/api/checkchild';*/
                $location.path('/dashboard')
            }, function(errorResponse){
                console.log('error'+JSON.stringify(errorResponse));
                $scope.error = errorResponse.data.message;
            });
        };

    }
]);