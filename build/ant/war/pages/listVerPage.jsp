<%@ page import="teste.domain.PageImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js%22%3E"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
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
            text-align: white;
        }
        input{
            color:black;
        }
        span{
            color:black;
        }
        .glyphicon glyphicon-ok {
            color:green
        }
    </style>
</head>
<body>
<div id="myApp" class="container" ng-app="myApp" ng-controller="myCtrl">
    <table class="clearfix">
        <thead>
        <tr>
            <th>Titulo</th>
            <th>Roles</th>
            <th>ID</th>
            <th>Adicionar Página</th>
            <th>Ver</th>
        </tr>
        </thead>
        <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="p in paginas" class="clearfix">
        <tr>
            <td>{{p.titulo}}</td>
            <td>{{p.roles}}</td>
            <td>{{p.id}}</td>
            <td> - </td>
            <td><a class="button" href="<%=request.getContextPath()%>/verPage.do?id={{p.id}}">
                <span class="glyphicon glyphicon-ok"></span>
            </a></td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    function send(serviceName, method, data, callbackOk){
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/soa",
            contentType: "application/json",
            dataType: 'json',
            data:  JSON.stringify({
                servico: serviceName,
                op: method,
                data: data,
            }),
            success: function(result){
                console.log(JSON.stringify(result));
                callbackOk(result.data);
            },
            statusCode:{
                401: function(){
                    console.log(401);
                }
            },
            error: function(resposta)
            {

            }
        });
    }

    let app = angular.module("myApp", []);
    app.controller("myCtrl", function($scope) {
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
        $scope.listPages();
    });
</script>
</body>
</html>
