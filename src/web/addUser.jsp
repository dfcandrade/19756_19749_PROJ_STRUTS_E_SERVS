<%@ page import="teste.domain.UserImpl" %>
<%@ page import="teste.domain.User" %>
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

        table th{
            color: white;
        }

        .table{
            color: white;
        }

        .table thead tr th{
            color: white;
        }
    </style>
</head>
<body>
<div id="myApp" class="container" ng-app="myApp" ng-controller="myCtrl">
    <div >
        <table style="width: 75%;margin-left: 1%;" class="clearfix table">
            <thead>
            <tr>
                <th>Nome</th>
                <th>Username</th>
                <th>Password</th>
                <th>Email</th>
                <th>Roles</th>
                <th>Adicionar</th>
            </tr>
            </thead>
            <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="u in users" class="clearfix">
            <tr>
                <td>{{u.nome}}</td>
                <td>{{u.username}}</td>
                <td>**********</td>
                <td>{{u.email}}</td>
                <td>{{u.roles}}</td>
            </tr>
            </tbody>
            <tbody>
            <tr>
                <td><input style="color:black" type="text" ng-model="u.nome"></td>
                <td><input style="color:black" type="text" ng-model="u.username"></td>
                <td><input style="color:black" type="text" ng-model="u.password"></td>
                <td><input style="color:black" type="text" ng-model="u.email"></td>
                <td>
                    <select style="color:black" ng-model="u.roles" ng-options="u for u in roles">
                    </select>
                </td>
                <td>
                    <button ng-click="saveUser(u)" onclick="window.location.reload();">
                        <span style="color:darkgreen;" class="glyphicon glyphicon-plus"/>
                    </button>
                </td>

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
        $scope.roles = ["admin", "criadorPagina", "normal"]
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

        $scope.saveUser = function (u){
            send(
                "user.ServicoUser",
                "addUser",
                u,
                function(result)
                {
                    angular.merge(u,result);
                    $scope.$apply();
                },
            );

        }
        $scope.listarUsers();
    });
</script>
</body>
</html>
