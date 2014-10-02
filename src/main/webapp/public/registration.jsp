<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
      
<div class="row-fluid">
    <div class="span8 offset2 well" ng-controller="registrationController">
        <legend><spring:message code="registration.header" /></legend>
        
        <form name="userRegistrationForm" novalidate class="form-horizontal" >
                <div class="form-group lead">
                        <label class="col-sm-2 control-label">* <spring:message code="users.name"/>:</label>
	                    <div  class="col-sm-10">
		                    <input type="text" class="form-control"
		                               required
		                               autofocus
		                               ng-model="user.name"
		                               name="name"
		                               placeholder="<spring:message code='sample.name'/>"/>
		                               
		                        <div class="input-append">
		                        <label>
		                                <span class="text-error"
		                                      ng-show="displayValidationError && userRegistrationForm.name.$error.required">
		                                        <spring:message code="required"/>
		                                </span>
		                        </label>
		                    	</div>
                    	</div>
                </div>
                <div class="form-group lead">
                       	<label class="col-sm-2 control-label">* <spring:message code="users.email"/>:</label>
                   		<div  class="col-sm-10">
	                        <input type="text" class="form-control"
	                               required
	                               ng-model="user.email"
	                               name="email"
	                               placeholder="<spring:message code='sample.email'/> "/>
	                        <div class="input-append">
	                        <label>
	                                <span class="text-error"
	                                      ng-show="displayValidationError && userRegistrationForm.email.$error.required">
	                                    <spring:message code="required"/>
	                                </span>
	                        </label>
	                    	</div>
                    	</div>
                </div>
                
                <div class="form-group lead">
                    <label class="col-sm-2 control-label">* <spring:message code="users.password"/>:</label>
                    <div class="col-sm-10">
		                    <input type="password" class="form-control"
		                               required
		                               ng-model="user.password"
		                               name="password"
		                               placeholder="<spring:message code='sample.password'/> "/>
		                    
		                    <div class="input-append">
		                        <label>
		                                <span class="text-error"
		                                      ng-show="displayValidationError && userRegistrationForm.password.$error.required">
		                                    <spring:message code="required"/>
		                                </span>
		                        </label>
		                    </div>
		             </div>
                </div>
                
                <div class="form-group lead">
                    <label class="col-sm-2 control-label">* <spring:message code="users.enabled"/>:</label>
                    <div class="col-sm-10">
	                   <%--  <input type="text" class="form-control"
	                               required
	                               ng-model="user.enabled"
	                               name="enabled"
	                               placeholder="<spring:message code='sample.enabled'/> "/> --%>
	                               
					     <input type="radio"  class="form-control" required name="enabled" value="yes" ng-model="user.enabled"> Yes
					     <input type="radio"  class="form-control" required name="enabled" value="no" ng-model="user.enabled">  No
										
	                    <div class="input-append">
	                        <label>
	                                <span class="text-error"
	                                      ng-show="displayValidationError && userRegistrationForm.enabled.$error.required">
	                                    <spring:message code="required"/>
	                                </span>
	                        </label>
	                    </div>
	                </div>
                </div>
                
                <div class="form-group lead">
                    <label class="col-sm-2 control-label">* <spring:message code="users.role"/>:</label>
                    <div class="col-sm-10">
	                   <%--  <input type="text" class="form-control"
	                               required
	                               ng-model="user.role"
	                               name="role"
	                               placeholder="<spring:message code='sample.role'/> "/> --%>
						<select ng-model="user.role"
								class="form-control"
								required
								name="role">
						    	<option value="" selected="selected">Select Role</option>
						    	<option value="ROLE_USER">User</option>
						    	<option value="ROLE_ADMIN">Admin</option>
						</select>
	                    <div class="input-append">
	                        <label>
	                                <span class="text-error"
	                                      ng-show="displayValidationError && userRegistrationForm.role.$error.required">
	                                    <spring:message code="required"/>
	                                </span>
	                        </label>
	                    </div>
	               	</div>
                </div>
                <div class="form-group lead">
                	<div class="col-sm-10">
                	<input type="submit"
                       class="btn btn-inverse"
                       ng-click="registerUser(userRegistrationForm);"
                       value='<spring:message code="register"/>'/>
                   	</div>
                </div>
                <div class="small-4"><a title='<spring:message code="login.signIn"/>?' href="<c:url value='/login'/>"><p><spring:message code="login.signIn"/>?</p></a></div>
        </form>
    </div>
</div>
<script src="<c:url value='/resources/js/pages/user.js' />"></script>
