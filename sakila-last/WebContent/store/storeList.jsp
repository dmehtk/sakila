<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>STORELIST</title>
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
        <div>        
        	<%	
	        	request.setCharacterEncoding("utf-8");	
	    		// 검색 비지니스 로직 
	    		String searchWord = "";
	    	
	    		if(request.getParameter("searchWord") != null){
	    			searchWord = request.getParameter("searchWord");
	    		}
	    		StoreDao storeDao=new StoreDao();
	    		ArrayList<StoreAndStaffAndAddress> list=storeDao.selectStoreListAll(searchWord);
	    		
	    		int searchStoreId=0;
				//인벤토리id 선택했을 경우
		    	if(request.getParameter("storeId")!=null && request.getParameter("storeId")!=""){
		    		searchStoreId = Integer.parseInt(request.getParameter("storeId"));
		    		list = storeDao.selectStoreAll(searchStoreId);
		    	}else{
		    		
		    		list = storeDao.selectStoreListAll(searchWord);
		    	} 		
        	%>
        	<h1 style="padding-top: 30px;">STORE LIST</h1>			
			<input class="form-control" id="myInput" name="searchWord" type="text" placeholder="Search..">
		  	<br>
			<br>
			<!-- 출력내용 -->
			<table class="table table-bordered table-hover">
				<thead class="thead-light">
					<tr>
						<th>상점 번호</th>
						<th>상점 관리자 번호</th>
						<th>관리자 이름</th>
						<th>주소 번호</th>
						<th>주소</th>
						<th>업데이트 날짜</th>
					</tr>	
				</thead>
				<tbody id="myTable">
					<%		//출력
						for(StoreAndStaffAndAddress s:list ){
					%>
					<tr>
						<td><%=s.getStore().getStoreId()%></td>
						<td><%=s.getStore().getManagerStaffId()%></td>
						<td><%=s.getStaff().getFirstName()+" "+s.getStaff().getLastName()%></td>
						<td><%=s.getStore().getAddressId()%></td>
						<td><%=s.getAddress().getAddress()%></td>
						<td><%=s.getStore().getLastUpdate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
        </div>
    </div>
	<script>
		$(document).ready(function(){
		  $("#myInput").on("keyup", function() {
		    var value = $(this).val().toLowerCase();
		    $("#myTable tr").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		});
	</script> 
</body>
</html>

