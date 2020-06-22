<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>InsertAddressForm</title>
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
<%
	request.setCharacterEncoding("utf-8");
	
	AddressDao addressDao = new AddressDao();
	int insertAddressId = addressDao.selectAddressIdMax();
	
	CityDao cityDao = new CityDao();
	ArrayList<City> list = cityDao.selectCityListAll();
%>
<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #c3e6cb;"></div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include>
    </div>
    <div id="section">
    	<h1 style="padding-top: 30px;">ADDRESS 입력</h1>
   		<div class="row" style="margin:0">
			<div class="col-*-*"> 		
	        	<form method="post" action="<%=request.getContextPath()%>/address/insertAddressAction.jsp">
	          		<table class="table table-bordered table-hover">
	          			<tbody>
		        			
		        			<tr>
		        				<td>ADDRRESS</td> 
		        				<td><input class="form-control-plaintext inputstl" placeholder="주소" type="text" name="address"></td>
		        			</tr>
		        			<tr>
		        				<td>ADDRRESS2</td>
		        				<td><input class="form-control-plaintext inputstl" placeholder="주소2" type="text" name="address2"></td>
		        			</tr>
		        			<tr>
		        				<td>DISTRICT</td>
		        				<td><input class="form-control-plaintext inputstl" placeholder="지역" type="text" name="district"></td>
		        			</tr>
		        			<tr>
		        				<td>CITY</td>
		        				<td> 
		        					<select class="form-control inputstl"  name="cityId">
		        					<%
		        						for(City ci: list){
		        					%>
		        						<option value="<%=ci.getCityId()%>">
		        							<%=ci.getCity()%>
		        						</option>
		        					<%
		        						}
		        					%>
		        					</select>
		        				</td>
		        			</tr>
		        			<tr>
		        				<td>POSTAL CODE</td>
		        				<td><input class="form-control-plaintext inputstl" placeholder="우편번호" type="text" name="postalCode"></td>
		        			</tr>
		        			<tr>
		        				<td>PHONE</td>
		        				<td><input class="form-control-plaintext inputstl" placeholder="핸드폰 번호" type="text" name="phone"></td>
		        			</tr>      
	        			</tbody>
	        		</table>
	        		<button class=" btn btn-outline-success" type="submit">입력</button>
	        	</form>
			</div> 
        	<div class="col-*-*"></div>
    	</div>
    </div>
</body>
</html>

