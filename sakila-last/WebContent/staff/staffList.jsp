<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>STAFFLIST</title>
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
        	<!-- staff 입력 넣기 -->
        	<%	
        		request.setCharacterEncoding("utf-8");	
        		// 검색 비지니스 로직 
        		String searchWord = "";
        		if(request.getParameter("searchWord") != null){
        			searchWord = request.getParameter("searchWord");
        		}
        		
        		StaffDao staffDao=new StaffDao();
        		ArrayList<StaffAndAddress> list=staffDao.selectStaffListAll(searchWord);
        		
        	%>
           <h1 style="padding-top: 30px;">STAFF LIST</h1>   
	 			<!-- 검색, 입력 출력 -->   
				<div id="accordion">
				    <div class="card">
				    	<!-- card header -->
				      	<div class="card-header" style="background-color: window;">
				        	<a class="card-link btn btn-outline-warning" data-toggle="collapse" href="#collapseOne">
				          		검색  
				        	</a>
				        	<a class="collapsed card-link btn btn-outline-warning" href="<%=request.getContextPath()%>/staff/insertStaffForm.jsp">
				        		입력  
				      		</a>
				      	</div>
				 	   	<!-- card body -->
				 	  	<div id="collapseOne" class="collapse" data-parent="#accordion">
							<div class="card-body">
						        <form method="post" action="<%=request.getContextPath()%>/staff/staffList.jsp">
									<input class="form-control-plaintext" placeholder="직원 이름" type="text" name="searchWord" value="<%=searchWord%>">
									<br>
									<button type="submit" class="btn btn-outline-light text-dark">Go</button>
								</form>
					       </div>
					    </div>
		
					</div>
				</div>
	    		<br>  
			<!-- 출력내용 -->
			<table class="table table-bordered table-hover">
				<thead class="thead-light">
					<tr>
						<th>직원 번호</th>
						<th>직원 이름</th>
						<th>주소</th>
						<th>이메일</th>
						<th>상점 번호</th>
						<th>활성여부</th>
						<th>유저 이름</th>
						<th>비밀번호</th>
					</tr>
				</thead>
				<tbody id="myTable">
					<%		
						for(StaffAndAddress sa:list){
					%>
					<tr>
						<td><%=sa.getStaff().getStaffId() %></td>
						<td><%=sa.getStaff().getFirstName()+" "+sa.getStaff().getLastName()%></td>
						<td><%=sa.getAddress().getAddress() %></td>
						<td><%=sa.getStaff().getEmail() %></td>
						<td><%=sa.getStaff().getStoreId() %></td>
						<td><%=sa.getStaff().getActive() %></td>
						<td><%=sa.getStaff().getUsername() %></td>
						<td><%=sa.getStaff().getPassword()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
        </div>
    </div>
</body>
</html>

