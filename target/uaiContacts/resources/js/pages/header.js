function LocationController($scope, $location) {
    if($location.$$absUrl.lastIndexOf('/contacts') > 0){
        $scope.activeURL = 'contacts';
    } else if($location.$$absUrl.lastIndexOf('/employees') > 0){
        $scope.activeURL = 'employees';
    } else{
        $scope.activeURL = 'home';
    }
}