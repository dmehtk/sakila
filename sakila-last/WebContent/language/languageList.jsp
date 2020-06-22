<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>LANGUAGELIST</title>
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
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #b8daff;"></div>
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
        		//컨트롤 로직
            	LanguageDao languageDao = new LanguageDao();
            	ArrayList<Language> list = languageDao.selectLanguageList(searchWord);
        		
        	%>
        	<h1 style="padding-top: 30px;">LANGUAGE LIST</h1>
			<!-- 검색, 입력 출력 -->    
			<div id="accordion">
			    <div class="card">
			    	<!-- card header -->
			      	<div class="card-header" style="background-color: window;">
			        	<a class="card-link btn btn-outline-primary" data-toggle="collapse" href="#collapseOne">
			          		검색  
			        	</a>
			        	<a class="collapsed card-link btn btn-outline-primary" data-toggle="collapse" href="#collapseTwo">
			        		입력  
			      		</a>
					</div>
			 	   <!-- card body -->
			 	  	<div id="collapseOne" class="collapse" data-parent="#accordion">
						<div class="card-body">
				        	<form method="post" action="<%=request.getContextPath()%>/language/languageList.jsp">
								<input class="form-control-plaintext" placeholder="나라 이름" type="text" name="searchWord" value="<%=searchWord%>">
								<br>
								<button type="submit" class="btn btn-outline-light text-dark">Go</button>
							</form>
				    	</div>
				    </div>
			  		<div id="collapseTwo" class="collapse" data-parent="#accordion">
						<div class="card-body">
				        	<form method="post" action="<%=request.getContextPath()%>/language/insertLanguageAction.jsp">				        		
								<input  class="form-control" type="text" name="insertWord">
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
        				<th>나라 번호</th>
        				<th>나라 이름</th>
        				<th>업데이트 날짜</th>
        			</tr>
				</thead>
				<tbody>
					<%
	        			for(Language language : list) {
	        		%>
	        		<tr>
	        			<td><%=language.getLanguageId()%></td>
	        			<td><%=language.getName()%></td>
	        			<td><%=language.getLastUpdate()%></td>
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

