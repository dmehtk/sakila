<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Payment Form</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>  
<meta charset="UTF-8">
</head>
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
		int rentalId = Integer.parseInt(request.getParameter("rentalId"));
			CustomerDao customerDao = new CustomerDao();
			StaffDao staffDao = new StaffDao();
			//RentalDao rentalDao = new RentalDao();
		
			
			String c = "";
			ArrayList<Customer> customerList = customerDao.selectCustomerList(c);
			ArrayList<StaffAndAddress> staffList = staffDao.selectStaffListAll(c);
			//ArrayList<RentalAndStaff> rentalList = rentalDao.selectRentalAndStaff(c);
			
	%>
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #b8daff;">
	</div>
	<div id="aside">
		<jsp:include page="/inc/sidemenu.jsp"></jsp:include>
	</div>
	<div id="section">
    	<h1 style="padding-top: 30px;">Payment Insert Form</h1>
        <div class="row" style="margin:0">
			<div class="col-*-*"> 	
				<form method="post" style="margin-bottom: 20px" action="<%=request.getContextPath()%>/payment/insertPaymentAction.jsp">
					<fieldset>
		    			<legend>INSERT PAYMENT</legend>
	    				<table class="table table-bordered table-hover">							
							<tbody>					
								<tr>
									<td>고객 이름</td>
									<td>
										<select class="form-control inputstl" name="customerName">
										<%
											for(Customer customer : customerList){
										%>
											<option value="<%=customer.getCustomerId()%>"><%=customer.getFullName()%></option>
										<%
											}
										%>
										</select>						
									</td>
								</tr>
								<tr>
									<td>직원 이름</td>
									<td>
										<select class="form-control inputstl" name="username">
										<%
											for(StaffAndAddress saa : staffList){
										%>
											<option value="<%=saa.getStaff().getStaffId()%>"><%=saa.getStaff().getUsername()%></option>
										<%
											}
										%>
										</select>						
									</td>
								</tr>
								<tr>
									<td>대여 번호</td>
									<td>
										<input class="form-control inputstl" type="text" value="<%= rentalId %>" name="rentalId" readonly="readonly">
										
									</td>
								</tr>
								<tr>
									<td>요금 합계</td>
									<td><input class="form-control inputstl" type="text" name="amount"></td>
								</tr>
							<tbody>
						</table>
		    		</fieldset>    	
	        		<button type="submit">목록 추가</button>
	        	</form>
        	</div>
    		<div class="col-*-*"></div>
    	</div>
    </div>
</body>
</html>











