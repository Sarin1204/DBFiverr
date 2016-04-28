/**
 * Created by vipul on 4/27/2016.
 */
angular.module('dashboard').controller('DashboardController',['$scope',
    '$routeParams', '$location','Dashboard','getUser',
    function($scope, $routeParams, $location, Dashboard,getUser){
        console.log("getUser"+JSON.stringify(getUser.user))
        Dashboard.getTopRequests.get({email_id: getUser.email_id},function(response){
            console.log('topRequests are '+JSON.stringify(response));
            $scope.topRequests = response.new_requests;
        }, function(error){
            console.log('Inside error for topRequests');
            $scope.errorMsg = 'Oops! Something unexpected occured!'
        });

    }
]);