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
<title>Insert Inventory Form</title>
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
		
		FilmDao filmDao = new FilmDao();
		String s = "";
		ArrayList<Film> filmList = filmDao.selectFilmList(s);
		
		StoreDao storeDao = new StoreDao();
		ArrayList<StoreAndStaffAndAddress> storeList = storeDao.selectStoreListAll(s);	
	%>
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #b8daff;">
	</div>
	<div id="aside">
		<jsp:include page="/inc/sidemenu.jsp"></jsp:include>
	</div>
	<div id="section">
    	<h1 style="padding-top: 30px;">Inventory Insert Form</h1>
        <div class="row" style="margin:0">
			<div class="col-*-*"> 	
				<form method="post" style="margin-bottom: 20px" action="<%=request.getContextPath()%>/inventory/insertInventoryAction.jsp">
					<fieldset>
		    			<legend>INSERT INVENTORY</legend>
	    				<table class="table table-bordered table-hover">							
							<tbody>					
								<tr>
									<td>영화제목</td>
									<td>
										<select class="form-control inputstl" name="film">
										<%
											for(Film f : filmList){
										%>
											<option value="<%=f.getFilmId()%>"><%=f.getTitle()%></option>
										<%
											}
										%>
										</select>						
									</td>
								</tr>
								<tr>	
									<td>가게 번호</td>
									<td>
										<select class="form-control inputstl" name="storeId">
										<%
											for(StoreAndStaffAndAddress sa : storeList){
										%>
											<option value="<%=sa.getStore().getStoreId()%>"><%=sa.getStore().getStoreId() %></option>
										<%
											}
										%>
										</select>						
									</td>
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











