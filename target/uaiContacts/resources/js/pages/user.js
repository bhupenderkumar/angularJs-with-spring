function registrationController($scope, $http, $window) {

    $scope.lastAction = '';

    $scope.errorOnSubmit = false;
    $scope.errorIllegalAccess = false;
    $scope.displayMessageToUser = false;
    $scope.displayValidationError = false;
    $scope.displaySearchMessage = false;
    $scope.displaySearchButton = false;
    $scope.displayCreateContactButton = false;
    
    $scope.registerUser = function (userRegistrationForm) {
        if (!userRegistrationForm.$valid) {
            $scope.displayValidationError = true;
            return;
        }
       // $scope.lastAction = 'register';
        
        var url = $scope.url = "/uaiContacts/registration/";
        
        var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}};

        $http.post(url, $.param($scope.user), config)
            .success(function (data) {
            	$window.location.href = 'http://localhost:8080/uaiContacts/login?success=true';
                //alert(data);
            })
            .error(function(data) {
            	alert("Error :"+data);
                //$scope.handleErrorInDialogs(status);
            });
    };
}
