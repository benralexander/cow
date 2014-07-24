var app = angular.module('App', []);

function Controller ($scope, $http) {

    $scope.section = [
        {name: 'Code', path: 'code/'},
        {name: 'Data', path: 'data/'}
    ];

    $scope.chapters = [
        {name: 'Chapter 5', path:'code/Chapter05', sections: [
            {name: 'Reusable Chart', path: 'code/Chapter05/Chart'},
            {name: 'Unit Testing', path: 'code/Chapter05/test'}
        ]
        }
    ];
}

app.config(['$routeProvider', function($routeProvider) {
    $routeProvider.
        when('/', {templateUrl: '/partials/index.html',   controller: Controller}).
        when('/examples', {templateUrl: '/partials/examples.html',   controller: Controller}).
        otherwise({redirectTo: '/'});
}