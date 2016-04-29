/**
 * Created by ramyavarakantham on 4/28/2016.
 */

angular.module('newRequest').factory('NewRequest',['$resource',
    function($resource) {
        return {
            getNewRequests:  $resource('/api/getNewRequests')
        };
    }
]);