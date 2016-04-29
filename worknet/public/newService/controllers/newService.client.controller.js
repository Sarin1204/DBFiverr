/**
 * Created by starn on 4/28/2016.
 */

angular.module('newService').controller('NewServiceController',['$scope',
    '$routeParams', '$location','NewService','getUser',
    function($scope, $routeParams, $location, NewService,getUser){
        console.log("getUser"+JSON.stringify(getUser.user))
        NewService.getTopServices.get({email_id: getUser.email_id},function(response){
            console.log('topServices are '+JSON.stringify(response));
            $scope.topServices = response.new_services;
        }, function(error){
            console.log('Inside error for topServices');
            $scope.errorMsg = 'Oops! Something unexpected occured!'
        });

    }
]);
