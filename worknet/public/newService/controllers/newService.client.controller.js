/**
 * Created by starn on 4/28/2016.
 */

angular.module('newService').controller('NewServiceController',['$scope',
    '$routeParams', '$location','NewService','getUser',
    function($scope, $routeParams, $location, NewService,getUser){
     /*   console.log("getUser"+JSON.stringify(getUser.user))
        NewService.getTopServices.get({email_id: getUser.email_id},function(response){
            console.log('topServices are '+JSON.stringify(response));
            $scope.topServices = response.new_services;
        }, function(error){
            console.log('Inside error for topServices');
            $scope.errorMsg = 'Oops! Something unexpected occured!'
        });*/

        $scope.submit_service = function(){
            console.log('Inside create_service');
            var service = new NewService.submitService({
                title: this.title,
                description: this.description
            });

            //console.log('person created is'+JSON.stringify(signup));

            service.$save(function(response){
                /*$window.location.href='http://localhost:3000/api/checkchild';*/
                $location.path('/newService')
            }, function(errorResponse){
                console.log('error'+JSON.stringify(errorResponse));
                $scope.error = errorResponse.data.message;
            });
        };

    }


]);
