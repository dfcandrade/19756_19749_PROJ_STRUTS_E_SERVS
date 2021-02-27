<%@ page import="teste.domain.SectionImpl"%>
<%@ page import="teste.domain.ComponentTextImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <style>
        body{
            background-color: darkslateblue;
            color: #ffffff;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
%>

<div id="myApp" ng-app="myApp" ng-controller="myCtrl">
    <h2>{{p.titulo}}</h2>

    <div ng-repeat="s in paginas.sections" style="padding-bottom: 1em;">
        <h2>Section Title.:</h2>
        <h3 >{{s.titulo}}</h3>
        <h2>Component.:</h2>
        <div ng-repeat="c in s.components" style="padding-bottom: 1em;">
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;{{ c.text }}</h3>
        </div>
        <hr/>
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
                "page.ServicoPage",
                "loadPage",
                {},
                {
                    id: $scope.id,
                },
                function(result) {
                    $scope.page = result;
                    $scope.$apply();
                },
                function(erro) {
                    alert(erro);
                    $scope.$apply();
                }
            );
        };

        $scope.loadPage();
    });
</script>
</body>
</html>