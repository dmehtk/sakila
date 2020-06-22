<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>sakila index</title>
<meta charset="UTF-8">
<style>
    body {
        padding: 0;
        margin: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background-position: 0 0;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size: cover;
        position: relative;
        overflow-y: auto;
    }
    
    #aside {
        width: 200px;
        height: 3000px;
        position: fixed;
        background: orange;
        overflow: hidden;
        float: left;
    }
    
    #section {
        margin-left: 300px;
        background: white;
    }
</style>
</head>
<body>
    <div id="aside">
    	<jsp:include page="/inc/sidemenu.jsp"></jsp:include>
    </div>
    <div id="section">
        <h1>INDEX</h1>
        <div>
            
        </div>
    </div>
</body>
</html>