/**
 * Created by ramyavarakantham on 4/29/2016.
 */
angular.module('insertnewrequest').factory('insertNewRequest',['$resource',
    function($resource) {
        return {
            signupPerson:  $resource('api/insertnewrequest')
        };
    }
]);