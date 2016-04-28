/**
 * Created by vipul on 4/27/2016.
 */
angular.module('dashboard').config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
        when('/dashboard', {
            templateUrl: 'dashboard/views/dashboard.client.view.html'
        })/*.
         otherwise({
         redirectTo: '/'
         });*/
    }
]);