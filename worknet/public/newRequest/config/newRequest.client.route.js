/**
 * Created by ramyavarakantham on 4/28/2016.
 */

angular.module('newRequest').config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
        when('/newRequest', {
            templateUrl: 'newRequest/views/NewRequest.client.view.html'
        })/*.
         otherwise({
         redirectTo: '/'
         });*/
    }
]);