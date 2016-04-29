/**
 * Created by ramyavarakantham on 4/28/2016.
 */

angular.module('newRequest').controller('NewRequestController',['$scope',
    '$routeParams', '$location','NewRequest','getUser',
    function($scope, $routeParams, $location, NewRequest,getUser){
        $scope.insert_newrequest = function(){
            console.log('Inside creating new request');
            var newrequest = new NewRequest.newRequest({
                title: this.title,
                description: this.description,
                days_to_complete: this.daystocomplete
            });

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