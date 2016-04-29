/**
 * Created by ramyavarakantham on 4/28/2016.
 */

angular.module('newRequest').controller('NewRequestController',['$scope',
    '$routeParams', '$location','NewRequest','getUser',
    function($scope, $routeParams, $location, NewRequest,getUser){
        console.log("getUser"+JSON.stringify(getUser.user))
        NewRequest.getNewRequests.get({email_id: getUser.email_id},function(response){
            console.log('new requests are '+JSON.stringify(response));
            $scope.newRequests = response.new_requests;
        }, function(error){
            console.log('Inside error for topRequests');
            $scope.errorMsg = 'Oops! Something unexpected occured!'
        });

    }
]);