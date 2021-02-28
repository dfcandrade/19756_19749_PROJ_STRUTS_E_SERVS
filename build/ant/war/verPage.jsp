<%@ page import="teste.domain.SectionImpl"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        body{
            background-color: darkslateblue;
        }
        hr{
            width: 75%;
            border:4px;
            color: black;
        }
        #titlePage {
            color: white;
            text-align: center;
        }
        .panel {
            margin-right: 50px;
            margin-left: 50px;
        }
        .panel-heading {
            text-align: center;
        }
        .panel-body {
            text-align: left;
        }

        #titleHR {
            width: 75%;
            border: 5px solid white;
            border-radius: 5px;
        }

    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
%>

<div id="myApp" ng-app="myApp" ng-controller="myCtrl">
    <h2 id="titlePage">{{paginas.titulo}}</h2>
    <hr id="titleHR">

    <div class="panel panel-default">
        <div class="panel-heading" ng-repeat="s in paginas.sections" style="padding-bottom: 1em;">
            <strong><h3>{{s.titulo}}</h3></strong>
            <div class="panel-body" ng-repeat="c in s.components" style="padding-bottom: 1em;">
                <h5>{{c.texto}}</h5>
                <hr>
            </div>
        </div>
    </div>
</div>
<script>
    function send(serviceName, method, data, callbackOk) {
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
            statusCode: {
                401: function(){
                    console.log(401);
                }
            },
            error: function(resposta) {

            }
        });
    }

    let app = angular.module("myApp", []);
    app.controller("myCtrl", function($scope) {

        $scope.id = <%=id%>;
        $scope.paginas = {
            sections: [
                { components: [] }
            ]
        };

        $scope.loadPage = function(){
            send(
                "paginas.ServicoPagina",
                "loadPage",
                {
                    id: $scope.id,
                },
                function(result) {
                    $scope.paginas = result;
                    $scope.$apply();
                }
            );
        };
        $scope.loadComponents = function(){
            send(
                "component.ServiceComponent",
                "returnComps",
                {
                    id: $scope.id,
                },
                function(result) {
                    $scope.paginas.sections.components = result;
                    $scope.$apply();
                }
            );
        };
        $scope.loadComponents();
        $scope.loadPage();
    });
</script>
</body>
</html>