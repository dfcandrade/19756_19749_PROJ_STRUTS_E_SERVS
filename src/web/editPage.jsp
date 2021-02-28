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
    th {
        color:white;
    }
</style>
<html>
<%
    String id = request.getParameter("id");
%>

<div id="myApp" ng-app="myApp" ng-controller="myCtrl">
    <h2 style="text-align: center">{{page.titulo}}</h2>

    <div class="container">
        <h3>Edit Sections</h3>

        <%--Create Section or Delete Section--%>

        <table class="table">
            <thead>
            <tr>
                <th style="color: #ffffff;">Title</th>
                <th>Guardar Section</th>
                <th>Apagar Section</th>
            </tr>
            </thead>
            <tbody ng-app="myApp" ng-controller="myCtrl" ng-repeat="s in page.sections">
                <tr>
                    <td>
                        {{s.titulo}}
                    </td>
                    <td colspan="1"></td>
                    <td>
                        <button class="button" ng-click="deleteSection(s)" onclick="window.location.reload();">
                            Apagar Sections
                        </button>
                    </td>
                </tr>
            </tbody>
            <tbody ng-app="myApp" ng-controller="myCtrl">
            <tr>
                <td>
                    <input class="input" type="text" ng-model="s.titulo">
                </td>
                <td>
                    <button class="button" ng-click="saveSection(s)" onclick="window.location.reload();">
                        Guardar Sections
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
        <%--Create or Delete components--%>
        <h3>Edit Components</h3>

            <table ng-app="myApp" ng-controller="myCtrl" class="table" ng-repeat="s in page.sections">
                <thead>
                <tr>
                    <th>
                        {{s.titulo}}<input type="button" value="Criar Componente" id="btnComp" style="color:black" ng-click="ShowHide(s.id)"/>
                    </th>
                    <th>
                        Image Path
                    </th>
                    <th>
                        Guardar
                    </th>
                    <th>
                        Apagar
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="c in s.components">
                    <td>
                        {{c.texto}}
                    </td>
                    <td>{{c.imgDir}}</td>
                    <td colspan="1">
                        {{c.idSection}}
                    </td>
                    <td>
                        <button class="button" ng-click="deleteComponent(c)" onclick="window.location.reload();">
                            Apagar Componentes
                        </button>
                    </td>
                </tr>
                </tbody>
                <tbody>
                    <tr ng-show="isVisible">
                        <td>
                            <input type="text" ng-model="c.texto">
                        </td>
                        <td>
                            <input type="text" ng-model="c.imgDir">
                        </td>
                        <td>
                            <button ng-click="saveComponent(c)" onclick="window.location.reload();">
                                Guardar Componente
                            </button>
                        </td>

                    </tr>
                </tbody>
            </table>
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
        $scope.idSec = [];
        $scope.isVisible = false;
        $scope.page = {
            sections: [
                { components: [] }
            ]
        };
        $scope.ShowHide = function (idSec) {
            //If DIV is visible it will be hidden and vice versa.
            $scope.idSec = idSec;
            $scope.isVisible = $scope.isVisible ? false : true;
            $scope.apply();
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
                    idPage: $scope.id,
                    titulo: s.titulo
                },
                function(result) {
                    angular.merge(s,result);
                    $scope.$apply();
                },
            );
        };

        $scope.saveComponent = function(c) {
            send(
                "component.ServiceComponent",
                "addComponent",
                {
                    idSection: $scope.idSec,
                    texto: c.texto,
                    imgDir: c.imgDir
                },
                function(result) {
                    angular.merge(c,result);
                    $scope.$apply();
                },
            );
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
            );
        };

        $scope.deleteComponent = function(c) {
            send(
                "component.ServiceComponent",
                "deleteComponent",
                {
                    id:c.id
                },
                function(result) {
                    angular.merge(c,result);
                    $scope.$apply();
                },

            );
        };
        $scope.loadPage();
    })
</script>