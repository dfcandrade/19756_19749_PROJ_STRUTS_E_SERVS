<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.swing.*" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="teste.domain.UserSession" %>
<%@ page import="teste.domain.User" %>

<%
    Cookie[] cookies = request.getCookies();
    Boolean loggedIn = false;
    String name = null;
    if(cookies != null) {
        for(Cookie c: cookies) {
            if(c.getName().equals("user")) {
                loggedIn = true;
                name =  (String) session.getAttribute("user");
                String encodedURL = response.encodeRedirectURL("login.do");
                response.sendRedirect(encodedURL);
            }
            else
                loggedIn = false;
        }
    }

%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<div>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="home.do"><strong style="color:white">Soft</strong>Ware</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="home.do">Home</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="">Page 2</a></li>
                <li><a href="">Page 3</a></li>
            </ul>
        </div>
    </nav>
</div>
