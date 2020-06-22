<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>FILMLIST</title>
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
    	
			<%
				request.setCharacterEncoding("utf-8");   	
			    FilmDao filmDao = new FilmDao();
			    ArrayList<Film> list = new ArrayList<Film>();
		      
		     	//list = filmDao.selectFilmListAll();
		     	
		     	// 검색 비지니스 로직 
		    	String searchWord = "";
		    	
		    	if(request.getParameter("searchWord") != null){
		    		searchWord = request.getParameter("searchWord");    		
		    	}
		    	
		    	list = filmDao.selectFilmList(searchWord); 	
		    	
		    	
		    	//페이징
		    	//현재 페이지
		    	int currentPage = 1;
		    	if(request.getParameter("currentPage")!= null){
		    		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		    	}
		    	
		    	//한 페이지에 몇개 출력할지
		    	int rowPerPage=10;
		    	
		    	//하단 페이지 그룹 수
		    	int pagePerGroup = 10;
		    	int pagePerGroupStart = 1;
		    	
		    	//마지막 페이지
		    	int lastPage = filmDao.selectLastPage(searchWord, rowPerPage);
		    	
		    	//현재 페이지 시작 데이터 번호
		    	int beginRow = (currentPage-1)*rowPerPage;
		    	
		    	//검색 없을 때
		    	list = filmDao.selectFilmBypage(searchWord, beginRow, rowPerPage);
		    	
			%>
	        <h1 style="padding-top: 30px;">FILM LIST</h1>   
	 			<!-- 검색, 입력 출력 -->   
				<div id="accordion">
				    <div class="card">
				    	<!-- card header -->
				      	<div class="card-header" style="background-color: window;">
				        	<a class="card-link btn btn-outline-primary" data-toggle="collapse" href="#collapseOne">
				          		검색  
				        	</a>
				        	<a class="collapsed card-link btn btn-outline-primary" href="<%=request.getContextPath()%>/film/insertFilmForm.jsp">
				        		입력  
				      		</a>
				      	</div>
				 	   	<!-- card body -->
				 	  	<div id="collapseOne" class="collapse" data-parent="#accordion">
							<div class="card-body">
						        <form method="post" action="<%=request.getContextPath()%>/film/filmList.jsp">
									<input class="form-control-plaintext" placeholder="영화 제목" type="text" name="searchWord" value="<%=searchWord%>">
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
						<th>영화제목</th>
						<th>개봉연도</th>
						<th>언어</th>
						<th>대여기간</th>
						<th>대여료</th>
						<th>길이</th>
						<th>보상비용</th>
						<th>등급</th>
						<th>특징</th>
					</tr>
				</thead>
				<tbody> 
					<%
 						for(Film f: list){
 					%>
						<tr>
							<td><%=f.getTitle() %></td>
							<td><%=f.getReleaseYear() %></td>
							<td><%=f.getLanguageId() %></td>
							<td><%=f.getRentalDuration() %></td>
							<td><%=f.getRentalRate() %></td>
							<td><%=f.getLength() %></td>
							<td><%=f.getReplacementCost() %></td>
							<td><%=f.getRating() %></td>
							<td><%=f.getSpecialFeatures() %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>	
			
			<!-- 하단 페이징 작업 -->
			<ul class="pagination" style="justify-content: center;">
			<%
				if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
			%>	
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
					href="filmList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%
				}else{  
			%>
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
					</li>
			<%		
				}
			
				if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
			%>
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
					</li>			
			<%
				}else{
			%>
					<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
					</li>
	       	<%
				}
			
				//하단 1~10페이지 출력 메소드(현재 페이지도 확인 가능)
				PagingDao pagingDao = new PagingDao();
				ArrayList<Paging> pa = pagingDao.groupPaging(currentPage, pagePerGroup, lastPage);
			
				for(Paging p : pa){
					if(p.getPageSelect() == true){ // 현재 페이지는  true 그 이외의 페이지는 false , 즉 현재페이지만 다른 색으로 구분해줌
			%>
							<li class="page-item"><a class="btn" style="background-color: #e9ecef;"
								href="filmList.jsp?currentPage=<%=p.getPageNum()%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
							</li>
			<%
						}else{
			%>
							<li class="page-item"><a class="btn" style="background-color: #b8daff;"
								href="filmList.jsp?currentPage=<%=p.getPageNum()%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
							</li>
			<%
						}	
				}
			
				if(currentPage<lastPage){ //현재 페이지값이 lastPage보다 크거나 같으면 다음 버튼 임시 비활성화
			%>			
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
					</li>	
			<%		
				}else{
			%>
					<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
							href="filmList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
					</li>
			<%
				}
			
				if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
			%>
					<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
					</li>
			<%
				}else{
			%>
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="filmList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
					</li>
			<%
				}
			%>
			</ul>
	</div>
</body>
</html>
