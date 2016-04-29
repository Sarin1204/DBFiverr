/**
 * Created by starn on 4/28/2016.
 */
angular.module('category').factory('Category',['$resource',
    function($resource) {
        return {
            getCategory:  $resource('/api/getCategory')
        };
    }
]);