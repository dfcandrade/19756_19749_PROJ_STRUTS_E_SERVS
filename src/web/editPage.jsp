<%@ page import="teste.domain.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld"  prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-nested.tld"  prefix="nested" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld"  prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld"  prefix="tiles" %>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js%22%3E"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
    body {
        background-color: darkslateblue;
    }
</style>
<html>
<%
    String id = request.getParameter("id");
%>

<div id="myApp" ng-app="myApp" ng-controller="myCtrl">
    <h2 >{{page.titulo}}</h2>

    <div class="container">
        <h3>Edit Sections</h3>

        <%--Create Section or Delete Section--%>
        <button class="button" ng-click="addSection()">
            Adicionar Section
        </button>
        <table class="table">
            <thead>
            <tr>
                <th style="color: #ffffff;">Title</th>
                <th colspan="2"></th>
            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="s in page.sections">
                <td>
                    <input class="input" type="text" ng-model="s.titulo">
                </td>
                <td>
                    <button class="button" ng-click="saveSection(s)">
                        Guardar Sections
                    </button>
                </td>
                <td>
                    <button class="button" ng-click="deleteSection(s); page.sections.splice($index,1)">
                        Apagar Sections
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
        <%--Create or Delete components--%>
        <h3>Edit Components</h3>
        <div ng-repeat="s in page.sections">
            <button ng-click="addComponent(s)">
                Aicionar Componente
            </button>
            <table class="table">
                <thead>
                <tr>
                    <th style="color: #ffffff;">{{s.titulo}}</th>
                    <th colspan="3"></th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="c in s.components">
                    <td>
                        <input type="text" ng-model="c.texto">
                    </td>
                    <td>
                        <button ng-click="saveComponentText(s, c)">
                            Guardar Componente
                        </button>
                    </td>
                    <td>
                        <button class="button" ng-click="deleteComponent(c); s.components.splice($index,1)">
                            <span class="icon"><i class="mdi mdi-delete"></i></span>
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <%--Table where can be show the page title, Section and the Component Text--%>
        <div >
            <div >
                <table class="clearfix" style="width: 75%;margin-left: 1%; color: #ffffff;" id="myTable">
                    <thead>
                    <tr>
                        <th>Page Title</th>
                        <th>Section</th>
                        <th>Component Text</th>
                    </tr>
                    </thead>
                    <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="s in page.sections" class="clearfix">
                    <tr ng-repeat="c in s.components" style=" border-bottom: #ffffff 1px solid;">
                        <td>{{page.titulo}}</td>
                        <td>{{s.titulo}}</td>
                        <td>{{c.texto}}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

              <pre>
                  {{page|json}}
              </pre>
    </div>
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

        $scope.id = <%=id%>;
        $scope.page = {
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
                    $scope.page = result;
                    $scope.$apply();
                }
            );
        };

        $scope.addSection = function() {
            let s = {
                '@class' : '<%=SectionImpl.class.getName()%>'
            };

            if(!$scope.page.sections)
                $scope.page.sections = [];
            $scope.page.sections.push(s);
        };

        $scope.addComponent = function(section) {
            let c = {
                "@class": "<%=ComponentImpl.class.getName()%>"
            };

            if(!section.components) {
                section.components = [];
            }
            section.components.push(c);
        };

        $scope.savePage = function() {
            send(
                "paginas.ServicoPagina",
                "addPage",
                $scope.page,
                function(result) {
                    angular.merge($scope.page,result);
                    $scope.$apply();
                }
            );
        };

        $scope.saveSection = function(s){
            send(
                "section.ServiceSection",
                "addSection",
                {
                    "idPage": $scope.id,
                    "s": s
                },
                function(result) {
                    angular.merge(s,result);
                    $scope.$apply();
                },
                function(erro)
                {
                    alert(erro);
                    $scope.$apply();
                }
            );
        };

        $scope.saveComponentText = function(c) {
            send(
                "component.ServiceComponent",
                "addComponent",
                {
                    //"idSection": s.id,
                    "c": c
                },
                function(result) {
                    angular.merge(c,result);
                    $scope.$apply();
                },
                function(erro)
                {
                    alert(erro);
                    $scope.$apply();
                }
            )
        };

        $scope.deleteSection = function(s) {
            send(
                "section.ServiceSection",
                "deleteSection",
                {
                    s,
                    "idSection": s.id
                },
                function(result) {
                    //$scope.loadPage();
                    $scope.$apply();
                },
                function (erro) {
                    alert(erro);
                    $scope.$apply();
                }
            )
        };

        $scope.deleteComponent = function(c) {
            send(
                "component.ServiceComponent",
                "deleteComponent",
                {
                    c,
                    "idComponent": c.id,
                    "idPage": $scope.id
                },
                function(result) {
                    //$scope.loadPage();
                    $scope.$apply();
                },
                function (erro) {
                    alert(erro);
                    $scope.$apply();
                }
            )
        };

        $scope.loadPage();
    })
</script>