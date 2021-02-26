<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.swing.*" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="teste.domain.UserSession" %>
<%@ page import="teste.domain.User" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<div>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="home.do"><strong style="color:white">Soft</strong>Ware</a>
            </div>
            <ul class="nav navbar-nav">
                <li id="navHome" class="active"><a href="../home.do"><span class="glyphicon glyphicon-home"/>Home</a></li>
                <li id="navPage" ><a href="">Page 2</a></li>
                <li><a href="">Page 3</a></li>
                <li id="navUser" ><a href="../login.jsp"><span class="glyphicon glyphicon-log-in"/>Login</a></li>
            </ul>
        </div>
    </nav>
</div>
