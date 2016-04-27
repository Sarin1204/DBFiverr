/**
 * Created by vipul on 4/26/2016.
 */
angular.module('signupPerson').controller('SignupPersonController',['$scope',
    '$routeParams', '$location','SignupPerson',
    function($scope, $routeParams, $location, SignupPerson){

        $scope.create_person = function(){
            console.log('Inside create_person');
            var signup = new SignupPerson.signupPerson({
                email: this.email,
                password: this.password,
                firstname: this.firstname,
                lastname: this.lastname
            });

            console.log('person created is'+JSON.stringify(signup));

            signup.$save(function(response){
                /*$window.location.href='http://localhost:3000/api/checkchild';*/
                $location.path('/dashboard')
            }, function(errorResponse){
                console.log('error'+JSON.stringify(errorResponse));
                $scope.error = errorResponse.data.message;
            });
        };

    }
]);