<%--
  Created by IntelliJ IDEA.
  User: jmachado
  Date: 28/10/2019
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="teste.web.LoginServlet" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>Login</title>
    <style>
        .login-form {
            border: hidden;
            padding: 20px;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }
        .form-group{
            padding-left:40px;
            padding-right:40px;
        }
        h3{
            text-align: center;
        }

        body{
            background-color: darkslateblue;
        }
    </style>
</head>
<body>
<div class="container" style="text-align:center;color:white;transform: translate(0%, 400%);">
    <h2><strong>Soft</strong>Ware</h2>
</div>

<div class="container login-form">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-horizontal" action="<%=request.getContextPath()%>/login" method="POST">
                <div class="input-group" style="padding-bottom: 10px;">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="username" class="form-control" placeholder="Username" type="text" name="username">
                </div>

                <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="password" class="form-control" placeholder="Password" type="password" name="password">
                </div>
                <div class="form-group" style="text-align: center;padding-top: 10px;">
                    <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>  Submeter</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
