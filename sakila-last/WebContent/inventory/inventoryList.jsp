<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>INVENTORYLIST</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
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
	padding: 20px;
	background: white;
}
</style>
</head>
<body>
	<div
		style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #ffeeba;"></div>
	<div id="aside">
		<jsp:include page="/inc/sidemenu.jsp"></jsp:include>
	</div>
	<div id="section">
		<div>
			<%
				//검색값 확인
				String searchWord = "";
				if (request.getParameter("searchWord") != null) {
					searchWord = request.getParameter("searchWord");
				}
				//컨트롤 로직
				InventoryDao inventoryDao = new InventoryDao();
				ArrayList<InventoryAndFilm> list = new ArrayList<InventoryAndFilm>();
	
				int currentPage=1;
				if(request.getParameter("currentPage")!=null){
					currentPage=Integer.parseInt(request.getParameter("currentPage"));
				}
				int rowPerPage=10;
				int beginPage=(currentPage-1)*rowPerPage;
				int pagePerGroup = 10;
				
				int searchInventoryId = 0;
				
				//인벤토리id 선택했을 경우
				if (request.getParameter("inventoryId") != null && request.getParameter("inventoryId") != "") {
					searchInventoryId = Integer.parseInt(request.getParameter("inventoryId"));
					list = inventoryDao.selectInventoryAndFilmAll(searchInventoryId);
				} else {
	
					list = inventoryDao.selectInventoryAndFilmListPaging(beginPage, rowPerPage, searchWord);
				}
				
				int lastPage =inventoryDao.selectLastPage(searchWord, rowPerPage);				
				

			%>
			<h1 style="padding-top: 30px;">InventoryList</h1>
			<!-- 검색, 입력 출력 -->
			<div id="accordion">
				<div class="card">
					<!-- card header -->
					<div class="card-header" style="background-color: window;">
						<a class="card-link btn btn-outline-warning"
							data-toggle="collapse" href="#collapseOne"> 검색 </a> 
						<a class="collapsed card-link btn btn-outline-warning"
							href="<%=request.getContextPath()%>/inventory/insertInventoryForm.jsp">
							입력 
						</a>
					</div>
					<!-- card body -->
					<div id="collapseOne" class="collapse" data-parent="#accordion">
						<div class="card-body">
							<form method="post"
								action="<%=request.getContextPath()%>/inventory/inventoryList.jsp">
								<input class="form-control-plaintext" placeholder="목록 번호 or 영화 번호" type="text" name="searchWord"
									value="<%=searchWord%>"> <br>
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
						<th>목록 번호</th>
						<th>영화 번호</th>
						<th>영화 제목</th>
						<th>상점 번호</th>
						<th>업데이트 날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (InventoryAndFilm inventoryfilm : list) {
					%>
					<tr>
						<td><%=inventoryfilm.getInventory().getInventoryId()%></td>
						<td><%=inventoryfilm.getInventory().getFilmId()%></td>
						<td><%=inventoryfilm.getFilm().getTitle()%></td>
						<td><a
							href="<%=request.getContextPath()%>/store/storeList.jsp?storeId=<%=inventoryfilm.getInventory().getStoreId()%>">
								<%=inventoryfilm.getInventory().getStoreId()%>
						</a></td>
						<td><%=inventoryfilm.getInventory().getLastUpdate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<%
			if (request.getParameter("inventoryId") != null && request.getParameter("inventoryId") != "") {
				
			}else{
			%>
			
			<!-- 페이징 -->
			<ul class="pagination justify-content-center">		
				<%
					if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
				%>	
					<li class="page-item"><a class="btn disabled" style="background-color: #ffeeba;"
						href="inventoryList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
					</li>
				<%
					}else{  
				%>
						<li class="page-item"><a class="btn" style="background-color: #ffeeba;"
							href="inventoryList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
						</li>
				<%		
					}
				
					if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
				%>
						<li class="page-item"><a class="btn" style="background-color: #ffeeba;"
							href="inventoryList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
						</li>			
				<%
					}else{
				%>
						<li class="page-item"><a class="btn disabled" style="background-color: #ffeeba;"
							href="inventoryList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
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
					<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/inventory/inventoryList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
					
				<%
						}else{
				%>
					<li class="page-item"><a class="btn" style="background-color:#ffeeba;" href="<%=request.getContextPath() %>/inventory/inventoryList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
				<%
						}
					}
				%>
				<%
					if(currentPage < lastPage){
				%>
					<li class="page-item"><a class="btn" style="background-color: #ffeeba;"
						href="inventoryList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
					</li>	
				<%		
					}else{
				%>
					<li class="page-item"><a class="btn disabled" style="background-color: #ffeeba;"
							href="inventoryList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
					</li>
				<%
					}
				
					if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
				%>
					<li class="page-item"><a class="btn disabled" style="background-color: #ffeeba;"
						href="inventoryList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
					</li>
				<%
					}else{
				%>
					<li class="page-item"><a class="btn" style="background-color: #ffeeba;"
						href="inventoryList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
					</li>
				<%
					}
				%>
			</ul>
			
			<%
				
			}
			%>
			
			
			
		
			
		</div>
	</div>
</body>
</html>
