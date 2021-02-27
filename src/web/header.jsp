<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.swing.*" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="teste.domain.UserSession" %>
<%@ page import="teste.domain.User" %>
<%@ page import="teste.servicos.logout.ServiceLogout" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%
    boolean isLogged = session.getAttribute("userLoggedIn")!=null;

%>
<style>
    ul {
        color:black;
    }
    li {
        color:black;
    }
</style>
<div>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="home.do"><strong>Soft</strong>Ware</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="" style="text-align: right;" id="navLogout"><a onclick="document.getElementById('logoutF').submit();"/>
                    <form id="logoutF" action="<%=request.getContextPath()%>/login" method="POST">
                    </form>
                </li>
                <li id="navHome" class="active"><a href="<%=request.getContextPath()%>/home.do">Home</a></li>
                <li id="navPage" ><a href="<%=request.getContextPath()%>/listPage.do">Páginas</a></li>
                <li id="navUser"><a href="<%=request.getContextPath()%>/listUser.do">Utilizadores</a></li>
            </ul>
        </div>
    </nav>
</div>

<script>
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
</script>
