/**
 * Created by ramyavarakantham on 4/28/2016.
 */

angular.module('newRequest').config(['AuthProvider','$routeProvider',
    function(AuthProvider,$routeProvider) {
        $routeProvider.
        when('/newRequest', {
            templateUrl: 'newRequest/views/NewRequest.client.view.html',
            resolve: {
                signedin:AuthProvider.checkSignedin
            }
        })/*.
         otherwise({
         redirectTo: '/'
         });*/
    }
]);