<%@ page import="teste.domain.UserImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        body{
            align-content: center;
            background-color: darkslateblue;
        }
    </style>
</head>
<body>
<div id="myApp" class="container" ng-app="myApp" ng-controller="myCtrl">
    <div >
        <table  style="width: 75%;margin-left: 1%;" class="table clearfix">
            <thead>
            <tr style="color: white">
                <th>Nome</th>
                <th>Username</th>
                <th>Email</th>
                <th>Roles</th>
            </tr>
            </thead>
            <tbody  ng-app="myApp" ng-controller="myCtrl" ng-repeat="u in users" class="clearfix">
            <tr style="color: white">
                <td>{{u.nome}}</td>
                <td>{{u.username}}</td>
                <td>{{u.email}}</td>
                <td>{{u.roles}}</td>
            </tr>
            </tbody>
        </table>

    </div>
</div>

<script>
    function send(nomeServico, method, data, callbackOk) {
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/soa",
            contentType: "application/json",
            dataType: 'json',
            data: JSON.stringify({
                servico: nomeServico,
                op: method,
                data: data,
            }),
            success: function (result) {
                console.log(JSON.stringify(result));
                callbackOk(result.data);
            },
            statusCode: {
                401: function () {
                    console.log(401);
                }
            },
            error: function (resposta) {

            }
        });
    }
    let app = angular.module("myApp", []);
    app.controller("myCtrl", function($scope){
        $scope.users = [];

        $scope.listarUsers = function (){
            send(
                "user.ServicoUser",
                "loadAll",
                {},
                function(result){
                    $scope.users = result;
                    $scope.$apply();
                },
            );
        };
        $scope.listarUsers();
    });
</script>
</body>
</html>
