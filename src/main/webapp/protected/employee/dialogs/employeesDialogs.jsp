<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/start/jquery-ui.css" type="text/css" media="all" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">   
        $(document).ready(function () {
            $('#dob').datepicker({
                changeYear: true,
                beforeShow: function (textbox, instance) {   
                instance.dpDiv.css({
                    marginTop: (-textbox.offsetHeight) + 'px',
                    marginLeft: textbox.offsetWidth + 'px'
                });
                }
            });
        });
    </script>
     -->
    
<div id="addEmployeesModal"
     class="modal hide fade in centering insertAndUpdateDialogs"
     role="dialog"
     aria-labelledby="addEmployeesModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <h3 id="addEmployeesModalLabel" class="displayInLine">
            <spring:message code="create"/>&nbsp;<spring:message code="employee"/>
        </h3>
    </div>
    <div class="modal-body" style="float: left;">
        <form name="newEmployeeForm" novalidate class="form-horizontal" >
            <div class="pull-left">
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.name"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.name"
                               name="name"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.name'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="displayValidationError && newEmployeeForm.name.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.department"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.department"
                               name="department"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.department'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="displayValidationError && newEmployeeForm.department.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.address"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.address"
                               name="address"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.address'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="displayValidationError && newEmployeeForm.address.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.salary"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.salary"
                               name="salary"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.salary'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="displayValidationError && newEmployeeForm.salary.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.dob"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.dob"
                               name="dob"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.dob'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="displayValidationError && newEmployeeForm.dob.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                
                <input type="submit"
                       class="btn btn-inverse"
                       ng-click="createEmployee(newEmployeeForm);"
                       value='<spring:message code="create"/>'/>
                <button class="btn btn-inverse"
                        data-dismiss="modal"
                        ng-click="exit('#addEmployeesModal');"
                        aria-hidden="true">
                    <spring:message code="cancel"/></button>
            </div>
        </form>
    </div>
    <span class="text-error dialogErrorMessage"
          ng-show="errorOnSubmit">
        <spring:message code="request.error"/>
    </span>
</div>

<div id="updateEmployeesModal"
     class="modal hide fade in centering insertAndUpdateDialogs"
     role="dialog"
     aria-labelledby="updateEmployeesModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <h3 id="updateEmployeesModalLabel" class="displayInLine">
            <spring:message code="update"/>&nbsp;<spring:message code="employee"/>
        </h3>
    </div>
    <div class="modal-body">
        <form name="updateEmployeeForm" novalidate>
            <input type="hidden"
                   required
                   ng-model="employee.id"
                   name="id"
                   value="{{employee.id}}"/>

            <div class="pull-left">
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.name"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.name"
                               name="name"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.name'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="disValidationError && updateEmployeeForm.name.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.department"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.department"
                               name="department"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.department'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="disValidationError && updateEmployeeForm.department.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.address"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.address"
                               name="address"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.address'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="disValidationError && updateEmployeeForm.address.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.salary"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.salary"
                               name="salary"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.salary'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="disValidationError && updateEmployeeForm.salary.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <div>
                    <div class="input-append">
                        <label>* <spring:message code="employees.dob"/>:</label>
                    </div>
                    <div class="input-append">
                        <input type="text"
                               autofocus
                               required
                               ng-model="employee.dob"
                               name="dob"
                               placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.dob'/> "/>
                    </div>
                    <div class="input-append">
                        <label>
                                <span class="text-error"
                                      ng-show="disValidationError && updateEmployeeForm.dob.$error.required">
                                    <spring:message code="required"/>
                                </span>
                        </label>
                    </div>
                </div>
                
                <input type="submit"
                       class="btn btn-inverse"
                       ng-click="updateEmployee(updateEmployeeForm);"
                       value='<spring:message code="update"/>'/>
                <button class="btn btn-inverse"
                        data-dismiss="modal"
                        ng-click="exit('#updateEmployeesModal');"
                        aria-hidden="true">
                    <spring:message code="cancel"/></button>
            </div>
        </form>
    </div>
    <span class="text-error dialogErrorMessage"
          ng-show="errorOnSubmit">
        <spring:message code="request.error"/>
    </span>
</div>

<div id="deleteEmployeesModal"
     class="modal hide fade in centering"
     role="dialog"
     aria-labelledby="searchEmployeesModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <h3 id="searchEmployeesModalLabel" class="displayInLine">
            <spring:message code="delete"/>&nbsp;<spring:message code="employee"/>
        </h3>
    </div>
    <div class="modal-body">
        <form name="deleteEnmployeeForm" novalidate>
            <p><spring:message code="delete.confirm"/>:&nbsp;{{employee.name}}?</p>

            <input type="submit"
                   class="btn btn-inverse"
                   ng-click="deleteEmployee();"
                   value='<spring:message code="delete"/>'/>
            <button class="btn btn-inverse"
                    data-dismiss="modal"
                    ng-click="exit('#deleteEmployeesModal');"
                    aria-hidden="true">
                <spring:message code="cancel"/>
            </button>
        </form>
    </div>
    <span class="text-error dialogErrorMessage"
          ng-show="errorOnSubmit">
        <spring:message code="request.error"/>
    </span>
    <span class="text-error dialogErrorMessage"
          ng-show="errorIllegalAccess">
        <spring:message code="request.illegal.access"/>
    </span>
</div>

<div id="searchEmployeeModal"
     class="modal hide fade in centering"
     role="dialog"
     aria-labelledby="searchEmployeesModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <h3 id="searchEmployeesModalLabel" class="displayInLine">
            <spring:message code="search"/>
        </h3>
    </div>
    <div class="modal-body">
        <form name="searchEmployeeForm" novalidate>
            <label><spring:message code="search.for"/></label>

            <div>
                <div class="input-append">
                    <input type="text"
                           autofocus
                           required
                           ng-model="searchFor"
                           name="searchFor"
                           placeholder="<spring:message code='employee'/>&nbsp;<spring:message code='employees.name'/> "/>
                </div>
                <div class="input-append displayInLine">
                    <label class="displayInLine">
                        <span class="text-error"
                              ng-show="disValidationError && searchEmployeeForm.searchFor.$error.required">
                            <spring:message code="required"/>
                        </span>
                    </label>
                </div>
            </div>
            <input type="submit"
                   class="btn btn-inverse"
                   ng-click="searchEmployee(searchEmployeeForm, false);"
                   value='<spring:message code="search"/>'
                    />
            <button class="btn btn-inverse"
                    data-dismiss="modal"
                    ng-click="exit('#searchEmployeeModal');"
                    aria-hidden="true">
                <spring:message code="cancel"/>
            </button>
        </form>
    </div>
    <span class="text-error dialogErrorMessage"
          ng-show="errorOnSubmit">
        <spring:message code="request.error"/>
    </span>
</div>


