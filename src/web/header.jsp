<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.swing.*" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="teste.domain.UserSession" %>
<%@ page import="teste.domain.User" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%
    Cookie[] cookies = request.getCookies();
    Boolean loggedIn = false;
    String name = null;
    if(cookies != null) {
        for(Cookie c: cookies) {
            if(c.getName().equals("user")) {
                loggedIn = true;
                name =  (String) session.getAttribute("user");
            }
            else
                loggedIn = false;
        }
    }

%>

<div>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="home.do"><strong>Soft</strong>Ware</a>
            </div>
            <ul class="nav navbar-nav">
                <li id="navHome" class="active"><a href="home.do">Home</a></li>
                <li id="navPage" ><a href="">Páginas</a></li>
                <li id="navUser"><a href="">Utilizadores</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                    <li id="navLogin"><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                    <li id="navLogout"><a href="login.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
            </ul>
        </div>
    </nav>
</div>

<script>
    $(function () {
        if(<%=loggedIn%>) {
            $("#navLogin").css("display", "none");
            $("#navLogout").css("display", "");
            $("#navHome").css("display", "");
            $("#navUser").css("display", "");
        } else {
            $("#navLogout").css("display", "none");
            $("#navHome").css("display", "none");
            $("#navUser").css("display", "none");
            $("#navLogin").css("display", "");
        }
    })
</script>
