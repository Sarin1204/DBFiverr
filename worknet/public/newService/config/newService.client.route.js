/**
 * Created by starn on 4/28/2016.
 */

angular.module('newService').config(['AuthProvider','$routeProvider',
    function(AuthProvider,$routeProvider) {
        $routeProvider.
        when('/newService', {
            templateUrl: 'newService/views/newService.client.view.html',
            resolve: {
                signedin:AuthProvider.checkSignedin
            }
        })/*.
         otherwise({
         redirectTo: '/'
         });*/
    }
]);