/**
 * Created by vipul on 4/23/2016.
 */
var mainApplicationModuleName = 'worknet';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngResource','ngRoute','ngTagsInput','ngAnimate','ui.bootstrap',
    'auth','home','getUser','signupPerson','signinPerson','dashboard']);

mainApplicationModule.config(['$locationProvider','$httpProvider',
    function($locationProvider,$httpProvider){
        $locationProvider.hashPrefix('!');
        $httpProvider.interceptors.push(function($q, $location)
        {
            return {
                response: function(response) {
                    // do something on success
                    return response;
                },
                responseError: function(response) {
                    if (response.status === 401) {
                        console.log("In responseError");
                        $location.url('/');
                    }
                    return $q.reject(response);
                }
            };
        });
    }
]);

if (window.location.hash === '#_=_') window.location.hash = '#!';

angular.element(document).ready(function(){
    angular.bootstrap(document, [mainApplicationModuleName]);
});