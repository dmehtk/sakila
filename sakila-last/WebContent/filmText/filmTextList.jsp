<%@page import="dao.FilmTextDao"%>
<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>FILM TEXT LIST</title>
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
			  String searchWord="";
			  if(request.getParameter("searchWord")!=null){
			  	searchWord=request.getParameter("searchWord");
			  }
		
			  FilmTextDao filmTextDao = new FilmTextDao();
			  
			//페이징
	    		//현재 페이지
				int currentPage = 1;
				if(request.getParameter("currentPage") != null){
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				
				//한 페이지에 몇개 출력할지
				int rowPerPage = 10;
				if(request.getParameter("rowPerPage") != null){
					rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
				}
							
				//하단 페이지 그룹 수
				int pagePerGroup = 10;
				int pagePerGroupStart = 1;
				//ActorDao actorDao = new ActorDao();
				
				//마지막 페이지
				int lastPage  = filmTextDao.selectLastPage(searchWord, rowPerPage);
				
				//현재 페이지 시작 데이터 번호
				int beginRow = (currentPage-1) * rowPerPage;	//1page = 0~9	2page=10~19
			  
			  
			  
		      	ArrayList<FilmText> list = filmTextDao.selectFilmTextAll(searchWord, beginRow, rowPerPage);		
			%>
		    <h1 style="padding-top: 30px;">FILM TEXT LIST</h1>   	
			<!-- 검색, 입력 출력 -->   
			<div id="accordion">
				<div class="card">
					<!-- card header -->
					<div class="card-header" style="background-color: window;">
				    	<a class="card-link btn btn-outline-primary" data-toggle="collapse" href="#collapseOne">
				         	검색  
				        </a>
					</div>
				    <!-- card body -->				      
				    <div id="collapseOne" class="collapse" data-parent="#accordion">
				    	<div class="card-body">
				        	<form method="post" action="<%=request.getContextPath()%>/filmText/filmTextList.jsp">
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
						<th>영화 번호</th>
						<th>영화 제목</th>
						<th>설명</th>
					</tr>
				</thead>
				<tbody> 
					<%
						for(FilmText ft: list){
					%>
					<tr>
						<td><%=ft.getFilmId()%></td>
						<td><%=ft.getTitle()%></td>
						<td><%=ft.getDescription()%></td>
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
					href="filmTextList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
		<%
			}else{
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmTextList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
		<%		
			}
		
			if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmTextList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
		<%
			}else{
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmTextList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">이전</a>						
				</li>
		<%
			}
		
			//하단 1~10페이지 출력 메소드(현재 페이지도 확인 가능)
			PagingDao pagingDao = new PagingDao();
			ArrayList<Paging> pa = pagingDao.groupPaging(currentPage, pagePerGroup, lastPage);
		
			for(Paging p : pa){
				if(p.getPageSelect() == true){
		%>
						<li class="page-item"><a class="btn" style="background-color: #e9ecef;"
							href="filmTextList.jsp?currentPage=<%=p.getPageNum()%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
						</li>
		<%
					}else{
		%>
						<li class="page-item"><a class="btn" style="background-color: #b8daff;"
							href="filmTextList.jsp?currentPage=<%=p.getPageNum()%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
						</li>
		<%
					}	
			}
		
			if(currentPage<lastPage){ //현재 페이지값이 lastPage보다 크거나 같으면 다음 버튼 임시 비활성화
		%>			
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmTextList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>	
		<%		
			}else{
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmTextList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>
		<%
			}
		
			if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
					href="filmTextList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
		<%
			}else{
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmTextList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
		<%
			}
		%>
		</ul>
		
		
		</div>			
	</div>
</body>
</html>




