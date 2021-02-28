<%@ page import="teste.domain.UserImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js%22%3E"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        body{
            align-content: center;
            background-color: darkslateblue;
        }

        .clearfix th, .clearfix td{
            border:  double white;
            color: white;
        }

        .clearfix tbody tr td{
            color: white;
            text-align: center;
        }
        .clearfix tbody tr td span{
            color: black;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="myApp" class="container" ng-app="myApp" ng-controller="myCtrl">
    <div >
        <table  style="width: 75%;margin-left: 1%;" class="clearfix">
            <thead>
            <tr>
                <th>Titulo</th>
                <th>Roles</th>
                <th>ID</th>
                <th>Apagar</th>
            </tr>
            </thead>
            <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="p in paginas" class="clearfix">
            <tr>
                <td>{{p.titulo}}</td>
                <td>{{p.roles}}</td>
                <td>{{p.iddono}}</td>
                <td><button ng-click="deletePage(p)">
                    <span class="glyphicon glyphicon-minus"></span>
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
        $scope.paginas = [];

        $scope.listPages = function() {
            send(
                "paginas.ServicoPagina",
                "loadAll",
                {},
                function(result) {
                    $scope.paginas = result;
                    $scope.$apply();
                }
            );
        };

        $scope.deletePage = function (p){
            send(
                "paginas.ServicoPagina",
                "deletePage",
                p,
                function(result)
                {
                    angular.merge(p,result);
                    $scope.$apply();
                },
            );
        }
        $scope.listPages();
    });

    function refresh(){
        location.reload();
    }
</script>
</body>
</html>
