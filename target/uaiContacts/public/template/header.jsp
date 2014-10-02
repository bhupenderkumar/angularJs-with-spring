<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="masthead">
  <%--   <h3 class="muted">
        <spring:message code='header.message'/>
    </h3> --%>

    <div class="navbar">
        <div class="navbar-inner">
            <div class="container">
                <ul class="nav navbar-nav navbar-left" ng-controller="LocationController">
                    <li ng-class="{'active': activeURL == 'home', '': activeURL != 'home'}" >
                        <a href="<c:url value="/"/>"
                           title='<spring:message code="header.home"/>'
                                >
                            <p><spring:message code="header.home"/></p>
                        </a>
                    </li>
                    <li ng-class="{'gray': activeURL == 'contacts', '': activeURL != 'contacts'}"><a title='<spring:message code="header.contacts"/>' href="<c:url value='/protected/contacts'/>"><p><spring:message code="header.contacts"/></p></a></li>
                    <li ng-class="{'gray': activeURL == 'employees', '': activeURL != 'employees'}"><a title='<spring:message code="header.employees"/>' href="<c:url value='/protected/employees'/>"><p><spring:message code="header.employees"/></p></a></li>
                </ul>
                <ul class="nav pull-right">
                    <li><a href="<c:url value='/logout' />" title='<spring:message code="header.logout"/>'><p class="displayInLine"><spring:message code="header.logout"/>&nbsp;(${user.name})</p></a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <%-- 
    <div class="navbar">
    <nav class="header-container navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
           <!--  <a class="navbar-brand" href="#/">Angular Js</a> -->
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav navbar-left">
            	<li ng-class="{'active': activeURL == 'home', '': activeURL != 'home'}" >
                        <a href="<c:url value="/"/>"
                           title='<spring:message code="header.home"/>'>
                                
                            <spring:message code="header.home"/>
                        </a>
                    </li>
                    <li ng-class="{'gray': activeURL == 'contacts', '': activeURL != 'contacts'}"><a title='<spring:message code="header.contacts"/>' href="<c:url value='/protected/contacts'/>"><spring:message code="header.contacts"/></a></li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
	</nav>

	</div> --%>
    
</div>
