<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld"  prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-nested.tld"  prefix="nested" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld"  prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld"  prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld"  prefix="tiles" %>
<style>
    body{
        background-color: darkslateblue;
    }
    /* .center-els{
         text-align: center;
         padding: 10px 25% 10px 25%;
         padding: 5px;
         margin: 5px;
     }*/
    a:link {
        color: white;
        background-color: transparent;
        text-decoration: none;
    }
    a:visited {
        color: white;
        background-color: transparent;
        text-decoration: none;
    }
    a:hover {
        color: black;
        background-color: transparent;
        text-decoration: underline;
    }
    a:active {
        color: white;
        background-color: transparent;
        text-decoration: underline;
    }
    img{
        text-align: center;
        color: #ffffff;
        cursor: pointer;
    }


</style>
<div class="container align-left clearfix" style="text-align: left">
    <a style="display:block;margin-right:auto;margin-left:auto;" href="<%=request.getContextPath()%>/listUser.do">
        <img src="./img/list_user.png"/>
        <p>Listar Utilizadores</p>
    </a>
    <a style="display:block;margin-right:auto;margin-left:auto;" href="<%=request.getContextPath()%>/addUser.do">
        <img src="./img/add_user.png"/>
        <p>Adicionar Utilizadores</p>
    </a>
    <a style="display:block;margin-right:auto;margin-left:auto;" href="<%=request.getContextPath()%>/delUser.do">
        <img src="./img/del_user.png"/>
        <p>Apagar Utilizadores</p>
    </a>
    <!--<a style="display:block;margin-right:auto;margin-left:auto;" href="">
        <img src="./img/list_user.png"/>
        <p>Gerir Utilizadores</p>
    </a>-->
</div>
<div class="container align-right clearfix" style="text-align: right;padding-bottom: 40%">
    <a style="display:block;margin-right:auto;margin-left:auto;" href="<%=request.getContextPath()%>/listPage.do">
        <img src="./img/add_page.png"/>
        <p>Listar Páginas</p>
    </a>

    <a style="display:block;margin-right:auto;margin-left:auto;" href="delPage.jsp">
        <img src="./img/del_page.png"/>
        <p>Apagar Páginas</p>
    </a>
</div>
