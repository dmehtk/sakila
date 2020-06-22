<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>INSERTSTAFFFORM</title>
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


<script>
	function showCustomer(str) {
	  var xhttp;  
	  if (str == "") {
	    document.getElementById("txtHint").innerHTML = "";
	    return;
	  }
	  xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	      document.getElementById("txtHint").innerHTML = this.responseText;
	    }
	  };
	  xhttp.open("GET", "showAddress.jsp?q="+str, true);
	  xhttp.send();
	}
</script>


</head>
<body>
<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #f5c6cb;"></div>
<div id="aside">
        <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
</div>
<div id="section">
<%

	StoreDao storeDao = new StoreDao();
	ArrayList<Integer> storeIdList = storeDao.selectStoreIdList();


	AddressDao addressDao = new AddressDao();
	ArrayList<Integer> addressIdList = addressDao.selectAddressIdList();
	
%>
	<div class="row" style="margin:0">

	<form method="post" action="<%=request.getContextPath() %>/customer/insertCustomerAction.jsp">
    	
    		<fieldset>
    			<legend>CUSTOMER</legend>
    			
    			<table class="table table-bordered table-hover">							
				<tbody>	
					<tr>
						<td>STORE ID</td>						
						<td>
							<select class="form-control inputstl" name="storeId">
								<%
		    						for(Integer storeId : storeIdList){
		    					%>
		    							<option value="<%=storeId%>">
		    								<%=storeId %>    							
		    							</option>
		    					<%
		    						}
		    					%>
							</select>
						</td>						
					</tr>						
					<tr>
						<td>FIRST NAME</td>						
						<td><input class="form-control inputstl" type="text" name="firstName"></td>
					</tr>
					<tr>
						<td>LAST NAME</td>						
						<td><input class="form-control inputstl" type="text" name="lastName"></td>
					</tr>
					<tr>
						<td>EMAIL</td>						
						<td><input class="form-control inputstl" type="text" name="email"></td>
					</tr>
					<tr>
						<td>ADDRESS ID</td>						
						<td>
							<select class="form-control inputstl" name="addressId">
								<%
		    						for(Integer addressId : addressIdList){
		    					%>
		    							<option value="<%=addressId%>">
		    								<%=addressId %>    							
		    							</option>
		    					<%
		    						}
		    					%>
							</select>
						</td>						
					</tr>				
					<tr>
						<td>CREATE DATE</td>
						<td><input class="form-control inputstl" type="text" name="createDate"></td>
					</tr>
					
					
				</tbody>
			</table>
    			
    		</fieldset>
	<button type="submit">입력</button>
    	</form>
    	</div>
    	<div class="col-*-*"></div>

 </div>
</body>
</html>
















