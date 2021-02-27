<%@ page import="teste.domain.PageImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        text-align: center;
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
                <th>Ver</th>
            </tr>
        </thead>
        <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="p in paginas" class="clearfix">
            <tr>
                <td>{{p.id}}</td>
                <td>{{p.titulo}}</td>
                <td>{{p.roles}}</td>
                <td><a class="button" href="<%=request.getContextPath()%>/verPage.do?id={{p.id}}">
                    <span class="icon"><i class="glyphicon glyphicon-ok"></i></span>
                </a></td>
            </tr>
        </tbody>
    </table>
</div>

<!--<div id="myApp" ng-app="myApp" ng-controller="myCtrl">
    <div>
        <button ng-click="addPage()">
            <span>Add Page</span>
        </button>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th>Titulo</th>
            <th colspan="3"></th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="p in pages">
            <td>
                <input type="text" ng-model="p.title">
            </td>
            <td>
                <button ng-click="savePage(p)">
                    <span><i class="glyphicon glyphicon-disk"></i></span>
                </button>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/page.do?id={{p.id}}">
                    <span><i class="glyphicon glyphicon-plus"></i></span>
                </a>
            </td>
            <td>
                <button ng-click="removePage(p); pages.splice($index,1)">
                    <span><i class="glyphicon glyphicon-less"></i></span>
                </button>
            </td>
        </tr>
        </tbody>
    </table>
    <div style="text-align: center;">
        <p><strong style="color: #ffffff;">Pages created</strong></p>
    </div>
    <div >
        <table class="clearfix" style="width: 75%;margin-left: 1%;" id="myTable">
            <thead>
            <tr>
                <th>Id</th>
                <th>Titulo</th>
            </tr>
            </thead>
            <tbody  ng-app="myApp" ng-controller="myCtrl" ng-repeat="p in pages" class="clearfix">
            <tr>
                <td>{{p.id}}</td>
                <td>{{p.titulo}}</td>
            </tr>
            </tbody>
        </table>

    </div>

</div>-->

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

        $scope.addPage = function(){
            let p = {
                '@class' : '<%=PageImpl.class.getName()%>'
            };
            $scope.paginas.push(p);
        };

        $scope.savePage = function(p){
            send(
                "paginas.ServicoPagina",
                "addPage",
                p,
                function(result)
                {
                    angular.merge(p, result);
                    $scope.$apply();
                },
                function(erro)
                {
                    alert(erro);
                    $scope.$apply();
                }
            );
        };

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
