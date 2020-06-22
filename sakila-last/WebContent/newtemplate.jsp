<%@page import="dao.FilmDao"%>
<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Film List</title>
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
        	
     	
%>
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #f5c6cb;">
	
	</div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
    </div>
    <div id="section">
        <h1 style="padding-top: 30px;">FILM LIST</h1>
        
        <div>
        
              
			  <p class="text text-danger">Type something in the input field to search the column:</p>  
			  <input class="form-control" id="myInput" name="searchWord" type="text" placeholder="Search..">
		  	<br>
          
            
            
            <br>
			<table border="1" class="table table-bordered table-hover">
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
						<th></th>
					</tr>
				</thead>
				<tbody id="myTable"> 
					<%
 						//for(Film f: list){
 					%>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					<%
						//}
					%>
				</tbody>
			</table>			
            
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
    </div>
</body>
</html>
