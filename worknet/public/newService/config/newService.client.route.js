/**
 * Created by starn on 4/28/2016.
 */

angular.module('newService').config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
        when('/newService', {
            templateUrl: 'newService/views/newService.client.view.html'
        })/*.
         otherwise({
         redirectTo: '/'
         });*/
    }
]);