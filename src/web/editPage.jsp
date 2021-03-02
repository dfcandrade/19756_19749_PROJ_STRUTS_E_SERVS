<%@ page import="teste.domain.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld"  prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-nested.tld"  prefix="nested" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld"  prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld"  prefix="tiles" %>
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
    <h2 style="color:white;text-align: center">{{page.titulo}}</h2>

    <div class="container">
        <h3 style="color:white">Edit Sections</h3>

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
                    <td style="color:white">
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
        <h3 style="color:white">Edit Components</h3>

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
                    <td style="color:white">
                        {{c.texto}}
                    </td>
                    <td style="color:white">{{c.imgDir}}</td>
                    <td colspan="1">
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
                        <td ng-controller="myCtrl">
                            <input file-model="myFile" style="color:black" type="file" class="form-control" id ="myFileField"/>
                            <!--<button ng-click="uploadFile()" class = "btn btn-primary">Upload File</button>-->
                            <!--<input type="text" ng-model="c.imgDir">-->
                        </td>
                        <td>
                            <button style="color:black" ng-click="saveComponent(c)" onclick="window.location.reload();">
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

    app.directive('fileModel', ['$parse', function ($parse) {
        return {
            restrict: 'A',
            link: function(scope, element, attrs) {
                let model = $parse(attrs.fileModel);
                let modelSetter = model.assign;
                element.bind('change', function(){
                    scope.$apply(function(){
                        modelSetter(scope, element[0].files[0]);
                    });
                });
            }
        };
    }]);

    app.service('fileUpload', ['$http', function ($http) {
        this.uploadFileToUrl = function(file, uploadUrl){
            let fd = new FormData();
            fd.append('file', file);
            $http.post(uploadUrl, fd, {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            })
                .success(function(){
                })
                .error(function(){
                });
        }
    }]);

    app.controller('myCtrl', ['$scope', 'fileUpload', function($scope, fileUpload) {
        $scope.myFile = [];
        $scope.id = <%=id%>;
        $scope.idSec = [];
        $scope.isVisible = false;
        $scope.page = {
            sections: [
                { components: [] }
            ]
        };
        let file = $scope.myFile;
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
            let uploadUrl = "<%request.getContextPath();%>/img/";
            send(
                "component.ServiceComponent",
                "addComponent",
                {
                    idSection: $scope.idSec,
                    texto: c.texto,
                    imgDir: file.toString()
                },
                function(result) {
                    fileUpload.uploadFileToUrl(file, uploadUrl);
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
    }]);
</script>