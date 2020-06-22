<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>CITYLIST</title>
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
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #c3e6cb;"></div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
    </div>
    <div id="section">
        <%
        	request.setCharacterEncoding("utf-8");
        	CityDao cityDao = new CityDao();
       	 	ArrayList<CityAndCountry> list;
       	 
	        String searchWord="";
	    	if(request.getParameter("searchWord")!=null){
	    		searchWord=request.getParameter("searchWord");
	    	}
	    	
	    	int currentPage = 1;
	    	if(request.getParameter("currentPage") != null){
	    		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	    	}
	    	int rowPerPage = 10;
	    	if(request.getParameter("rowPerPage") != null){
        		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
        	}
	    	int beginRow = (currentPage-1)*rowPerPage;
	    	int pagePerGroup = 10;
	    	
	    	int totalCount = cityDao.totalCount();
	    	int lastPage = cityDao.selectLastPage(searchWord, rowPerPage);
	    	int searchCountryId=0;
	    	
	    	//나라 선택했을 경우
	    	if(request.getParameter("countryId")!=null && request.getParameter("countryId")!=""){
	    		searchCountryId = Integer.parseInt(request.getParameter("countryId"));
	    		list = cityDao.selectCityAndCountry(searchCountryId);
	    	}else{
	    		//city 전체 출력
	    		list = cityDao.selectCityAndCountryAll(searchWord, beginRow, rowPerPage);	
	    	}
        %>
       	<h1 style="padding-top: 30px;">CITY LIST</h1>
       	<div>    
			<div id="accordion">
			    <div class="card">
			    	<!-- card header -->
			      	<div class="card-header" style="background-color: window;">
			        	<a class="card-link btn btn-outline-success" data-toggle="collapse" href="#collapseOne">
			          		검색  
			        	</a>			        	
				      	<a class="collapsed card-link btn btn-outline-success" href="<%=request.getContextPath()%>/city/insertCityForm.jsp">
				        		입력  
				      	</a>
			      	</div>
			      	<!-- card body -->				      
			      	<div id="collapseOne" class="collapse" data-parent="#accordion">
			        	<div class="card-body">
			        		<form method="post" action="<%=request.getContextPath()%>/city/cityList.jsp">
								<input class="form-control-plaintext" placeholder="도시 검색" type="text" name="searchWord" value="<%=searchWord%>">
								<br>
								<button type="submit" class="btn btn-outline-light text-dark">Go</button>
							</form>
			        	</div>
			      	</div>
			      	
			     </div>
			</div>
			<br>
			<table border="1" class="table table-bordered table-hover">
				<thead class="thead-light">
					<tr>
						<th>도시 번호</th>
						<th>도시 이름</th>
						<th>국가 이름</th>
					</tr>
				</thead>
				<tbody> 
					<%
						for(CityAndCountry cc: list){
					%>
					<tr>
						<td><%=cc.getCity().getCityId()%></td>
						<td><%=cc.getCity().getCity()%></td>
						<td><%=cc.getCountry().getCountry() %></td>						
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<!-- 페이징 -->
			<ul class="pagination justify-content-center">		
			<%
				if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
			%>	
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%
				}else{  
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%		
				}
			
				if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
			<%
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
				</li>
	       	<%
				}
			%>
			<%//세부 페이징
				Paging paging = new Paging();
				PagingDao pagingDao = new PagingDao();
				ArrayList<Paging> plList = pagingDao.groupPaging(currentPage, pagePerGroup, lastPage);
				
				for(Paging pa : plList){
					if(pa.getPageSelect() == true){
			%>
				<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/city/cityList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
				
			<%
					}else{
			%>
				<li class="page-item"><a class="btn" style="background-color:#c3e6cb;" href="<%=request.getContextPath() %>/city/cityList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
			<%
					}
				}
			%>
			<%
				if(currentPage < lastPage){
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
				</li>	
			<%		
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>
			<%
				}
			
				if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}else{
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="cityList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}
			%>
			</ul>
        </div>
	</div>
</body>
</html>




