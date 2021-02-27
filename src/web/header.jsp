<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.swing.*" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="teste.domain.UserSession" %>
<%@ page import="teste.domain.User" %>
<%@ page import="teste.servicos.logout.ServiceLogout" %>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%
   boolean isLogged = session.getAttribute("userLoggedIn")!=null;

%>

<div>
    <nav class="navbar navbar-default">
        <div>
            <div class="navbar-header">
                <a class="navbar-brand" href="home.do"><strong>Soft</strong>Ware</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="<%=request.getContextPath()%>/home.do">Home</a></li>
                <li><a onclick="document.getElementById('logoutF').submit();">Logout</a>
                </li>
            </ul>
            <form id="logoutF" action="<%=request.getContextPath()%>/login" method="POST">
            </form>
        </div>
    </nav>
</div>

<!--<script>
    $(function () {
        if(<%=isLogged%>) {
            $("#navLogout").css("display", "");
            $("#navHome").css("display", "");
            $("#navPage").css("display", "");
            $("#navUser").css("display", "");
        } else {
            $("#navHome").css("display", "none");
            $("#navPage").css("display", "none");
            $("#navUser").css("display", "none");
        }
    })
</script>-->
