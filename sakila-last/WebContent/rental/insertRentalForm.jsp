<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>INSERT RENTAL FORM</title>
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
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #ffeeba;"></div>
	<div id="aside">
	        <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
	</div>
	<div id="section">
		<%
			InventoryDao inventoryDao = new InventoryDao();
			ArrayList<Integer> selectInventoryIdList = inventoryDao.selectInventoryIdList();
			
			CustomerDao customerDao = new CustomerDao();
			ArrayList<Customer> selectCustomerIdList = customerDao.selectCustomerIdList();
			
			StaffDao staffDao = new StaffDao();
			ArrayList<Integer> selectStaffId = staffDao.selectStaffId();
			

			
		%>
		<div class="row" style="margin:0">

	<form method="post" action="<%=request.getContextPath() %>/rental/insertRentalAction.jsp">
    	
    		<fieldset>
    			<legend>Rental</legend>
    			
    			<table class="table table-bordered table-hover">							
				<tbody>	
					
					
					<tr>
						<td>RENTAL DATE</td>						
						<td><input class="form-control inputstl" type="text" name="rentalDate"></td>
					</tr>
					
					
					<tr>
						<td>INVENTORY ID</td>						
						<td>
							<select class="form-control inputstl" name="inventoryId">
								<%
		    						for(Integer inventoryId : selectInventoryIdList){
		    					%>
		    							<option value="<%=inventoryId%>">
		    								<%=inventoryId %>    							
		    							</option>
		    					<%
		    						}
		    					%>
							</select>
						</td>						
					</tr>	
					
					<tr>
						<td>CUSTOMER ID</td>						
						<td>
							<select class="form-control inputstl" name="customerId">
								<%
		    						for(Customer c : selectCustomerIdList){
		    					%>
		    							<option value="<%=c.getCustomerId()%>">
		    								<%=c.getFirstName()%> <%=c.getLastName() %>    							
		    							</option>
		    					<%
		    						}
		    					%>
							</select>
						</td>						
					</tr>	
					
					<tr>
						<td>STAFF ID</td>						
						<td>
							<select class="form-control inputstl" name="staffId">
								<%
		    						for(Integer staffId : selectStaffId){
		    					%>
		    							<option value="<%=staffId%>">
		    								<%=staffId%>    							
		    							</option>
		    					<%
		    						}
		    					%>
							</select>
						</td>						
					</tr>
	
					
				</tbody>
			</table>
    			
    		</fieldset>
	<button type="submit">입력</button>
    	</form>
    	</div>
    	<div class="col-*-*"></div>

 </div>

