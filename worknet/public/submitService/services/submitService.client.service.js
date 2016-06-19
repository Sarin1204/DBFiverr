/**
 * Created by starn on 4/29/2016.
 */

angular.module('submitService').factory('SubmitService',['$resource',
    function($resource) {
        return {
            submitService:  $resource('api/submitService')
        };
    }
]);
