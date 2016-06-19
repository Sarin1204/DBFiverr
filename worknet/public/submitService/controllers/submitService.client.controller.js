/**
 * Created by starn on 4/29/2016.
 */
angular.module('submitService').controller('SubmitServiceController',['$scope',
    '$routeParams', '$location','SubmitService',
    function($scope, $routeParams, $location, SubmitService){

        $scope.create_service = function(){
            console.log('Inside create_service');
            var service = new SubmitService.submitService({
                email: this.email,
                title: this.title,
                description: this.description,
                category: this.category
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
])