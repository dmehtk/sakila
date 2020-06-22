<%@page import="vo.Country"%>
<%@page import="dao.CountryDao"%>
<%@page import="vo.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>insertCityForm</title>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
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
		background-color: white;
    }
    
    #aside {
        width: 200px;
        height: 3000px;
        position: fixed;
        background: white;
        overflow: hidden;
        float: left;
    }
    
    #section {
        margin-left: 200px;
        padding : 20px;
        background: white;
    }
</style>
</head>
<body>
<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #c3e6cb;"></div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
    </div>
    <div id="section">
        <div>
			<%
				request.setCharacterEncoding("utf-8");
			
				CountryDao countryDao = new CountryDao();
				ArrayList<Country> list = new ArrayList<Country>();
				
				list = countryDao.selectCountryListAll("");
			%>		
			
		<h1 style="padding-top: 30px;">CITY 입력</h1>	
		<div class="row" style="margin:0">
			<div class="col-*-*"> 	   
		<form method="post" action="<%=request.getContextPath()%>/city/insertCityAction.jsp">
		    <table class="table table-bordered table-hover">
      			<tbody>
      				<tr>
      					<td>COUNTRY NAME</td>
      					<td>
      						<select class="form-control inputstl" name="countryId">
      						<%
      							for(Country c : list){
      						%>
      								<option value="<%=c.getCountryId() %>">
      									<%=c.getCountry() %>
      								</option>
      						<%
      							}
      						%>
      						</select>
      					</td>
      				</tr>
      				<tr>
      					<td>CITY NAME</td>
      					<td><input class="form-control inputstl" type="text" name="cityName"></td>
      				</tr>
      			</tbody>
	        </table>
			<button type="submit">CITY 입력</button>
		</form>
		</div>
		<div class="col-*-*"></div>
	</div>	
</div>
</div>
</body>
</html>
