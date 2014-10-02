function employeesController($scope, $http) {
    $scope.pageToGet = 0;

    $scope.state = 'busy';

    $scope.lastAction = '';

    $scope.url = "/uaiContacts/protected/employees/";

    $scope.errorOnSubmit = false;
    $scope.errorIllegalAccess = false;
    $scope.displayMessageToUser = false;
    $scope.displayValidationError = false;
    $scope.displaySearchMessage = false;
    $scope.displaySearchButton = false;
    $scope.displayCreateEmployeeButton = false;

    $scope.employee = {};

    $scope.searchFor = "";

    $scope.getEmployeeList = function () {
        var url = $scope.url;
        $scope.lastAction = 'list';

        $scope.startDialogAjaxRequest();

        var config = {params: {page: $scope.pageToGet}};

        $http.get(url, config)
            .success(function (data) {
                $scope.finishAjaxCallOnSuccess(data, null, false);
            })
            .error(function () {
                $scope.state = 'error';
                $scope.displayCreateEmployeeButton = false;
            });
    };

    $scope.populateTable = function (data) {
        if (data.pagesCount > 0) {
            $scope.state = 'list';

            $scope.page = {source: data.employees, currentPage: $scope.pageToGet, pagesCount: data.pagesCount, totalEmployees : data.totalEmployees};

            if($scope.page.pagesCount <= $scope.page.currentPage){
                $scope.pageToGet = $scope.page.pagesCount - 1;
                $scope.page.currentPage = $scope.page.pagesCount - 1;
            }

            $scope.displayCreateEmployeeButton = true;
            $scope.displaySearchButton = true;
        } else {
            $scope.state = 'noresult';
            $scope.displayCreateEmployeeButton = true;

            if(!$scope.searchFor){
                $scope.displaySearchButton = false;
            }
        }

        if (data.actionMessage || data.searchMessage) {
            $scope.displayMessageToUser = $scope.lastAction != 'search';

            $scope.page.actionMessage = data.actionMessage;
            $scope.page.searchMessage = data.searchMessage;
        } else {
            $scope.displayMessageToUser = false;
        }
    };

    $scope.changePage = function (page) {
        $scope.pageToGet = page;

        if($scope.searchFor){
            $scope.searchEmployee($scope.searchFor, true);
        } else{
            $scope.getEmployeeList();
        }
    };

    $scope.exit = function (modalId) {
        $(modalId).modal('hide');

        $scope.employee = {};
        $scope.errorOnSubmit = false;
        $scope.errorIllegalAccess = false;
        $scope.displayValidationError = false;
    };

    $scope.finishAjaxCallOnSuccess = function (data, modalId, isPagination) {
        $scope.populateTable(data);
        $("#loadingModal").modal('hide');

        if(!isPagination){
            if(modalId){
                $scope.exit(modalId);
            }
        }

        $scope.lastAction = '';
    };

    $scope.startDialogAjaxRequest = function () {
        $scope.displayValidationError = false;
        $("#loadingModal").modal('show');
        $scope.previousState = $scope.state;
        $scope.state = 'busy';
    };

    $scope.handleErrorInDialogs = function (status) {
        $("#loadingModal").modal('hide');
        $scope.state = $scope.previousState;

        // illegal access
        if(status == 403){
            $scope.errorIllegalAccess = true;
            return;
        }

        $scope.errorOnSubmit = true;
        $scope.lastAction = '';
    };

    $scope.addSearchParametersIfNeeded = function(config, isPagination) {
        if(!config.params){
            config.params = {};
        }

        config.params.page = $scope.pageToGet;

        if($scope.searchFor){
            config.params.searchFor = $scope.searchFor;
        }
    };

    $scope.resetEmployee = function(){
        $scope.employee = {};
    };

    $scope.createEmployee = function (newEmployeeForm) {
        if (!newEmployeeForm.$valid) {
            $scope.displayValidationError = true;
            return;
        }
        $scope.lastAction = 'create';

        var url = $scope.url;

        var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}};

        $scope.addSearchParametersIfNeeded(config, false);

        $scope.startDialogAjaxRequest();

        $http.post(url, $.param($scope.employee), config)
            .success(function (data) {
                $scope.finishAjaxCallOnSuccess(data, "#addEmployeesModal", false);
            })
            .error(function(data, status, headers, config) {
                $scope.handleErrorInDialogs(status);
            });
    };

    $scope.selectedEmployee = function (employee) {
        var selectedEmployee = angular.copy(employee);
        $scope.employee = selectedEmployee;
    };

    $scope.updateEmployee = function (updateEmployeeForm) {
        if (!updateEmployeeForm.$valid) {
            $scope.displayValidationError = true;
            return;
        }
        $scope.lastAction = 'update';

        var url = $scope.url + $scope.employee.id;

        $scope.startDialogAjaxRequest();

        var config = {};

        $scope.addSearchParametersIfNeeded(config, false);

        $http.put(url, $scope.employee, config)
            .success(function (data) {
                $scope.finishAjaxCallOnSuccess(data, "#updateEmployeesModal", false);
            })
            .error(function(data, status, headers, config) {
                $scope.handleErrorInDialogs(status);
            });
    };

    $scope.searchEmployee = function (searchEmployeeForm, isPagination) {
        if (!($scope.searchFor) && (!searchEmployeeForm.$valid)) {
            $scope.displayValidationError = true;
            return;
        }

        $scope.lastAction = 'search';

        var url = $scope.url +  $scope.searchFor;

        $scope.startDialogAjaxRequest();

        var config = {};

        if($scope.searchFor){
            $scope.addSearchParametersIfNeeded(config, isPagination);
        }

        $http.get(url, config)
            .success(function (data) {
                $scope.finishAjaxCallOnSuccess(data, "#searchEmployeeModal", isPagination);
                $scope.displaySearchMessage = true;
            })
            .error(function(data, status, headers, config) {
                $scope.handleErrorInDialogs(status);
            });
    };

    $scope.deleteEmployee = function () {
        $scope.lastAction = 'delete';

        var url = $scope.url + $scope.employee.id;

        $scope.startDialogAjaxRequest();

        var params = {searchFor: $scope.searchFor, page: $scope.pageToGet};

        $http({
            method: 'DELETE',
            url: url,
            params: params
        }).success(function (data) {
                $scope.resetEmployee();
                $scope.finishAjaxCallOnSuccess(data, "#deleteEmployeesModal", false);
        }).error(function(data, status, headers, config) {
                $scope.handleErrorInDialogs(status);
        });
    };

    $scope.resetSearch = function(){
        $scope.searchFor = "";
        $scope.pageToGet = 0;
        $scope.getEmployeeList();
        $scope.displaySearchMessage = false;
    };

    $scope.getEmployeeList();
}
