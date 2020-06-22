<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
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
        background-color: #B0D4DE;
    }
    
    #aside {
        width: 210px;
        height: 3000px;
        position: fixed;
        background: white;
        overflow: hidden;
        float: left;
    }
    
    #section {
        margin-left: 200px;
        background: white;
    }
</style>
</head>
<body>
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
        		
        		
        	%>
        	
		  <form method="post" action="<%=request.getContextPath()%>/staff/staffList.jsp">      	
			
			  <h2>STAFF LIST</h2>
			  <p class="text text-primary">Type something in the input field to search the column:</p>  
			  <input class="form-control" id="myInput" name="searchWord" type="text" placeholder="Search..">
		  	<br>
          </form>
			
			<br>
			<!-- 출력내용 -->
			<table class="table table-bordered table-hover">
				<thead class="thead-light">
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody id="myTable">
					<%		//출력
						//for(  : ){
					%>
					<tr>
						<td><%=%></td>
						<td><%=%></td>
			
					</tr>
					<%
						//}
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

