<%@page import="vo.Paging"%>
<%@page import="dao.PagingDao"%>
<%@page import="vo.FilmActorAndFilmAndActor"%>
<%@page import="vo.FilmActor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.FilmActorDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FILM ACTOR LIST</title>
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
	      	
	    FilmActorDao filmActorDao = new FilmActorDao();
	    //ArrayList<FilmActor> list = filmActorDao.selectFilmActorListAll();
	    // 검색 비지니스 로직 
	 	String searchWord = "";
	 	
	 	if(request.getParameter("searchWord") != null){
	 		searchWord = request.getParameter("searchWord");
	 	}
	    ArrayList<FilmActorAndFilmAndActor> list;
	    // = filmActorDao.selectFilmActorListAll(searchWord);
	    
	    
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
		
		
		int searchCustomerId = 0;
		
		
		int lastPage = 0;
		int beginRow = 0;
		
		lastPage  = filmActorDao.selectLastPage(searchWord, rowPerPage);
		beginRow = (currentPage-1) * rowPerPage;	//1page = 0~9	2page=10~19
		list = filmActorDao.selectFilmActorListAll(searchWord, beginRow, rowPerPage);
	%>
        <h1 style="padding-top: 30px;">FILM ACTOR LIST</h1>
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
			        		<form method="post" action="<%=request.getContextPath()%>/filmActor/filmActorList.jsp">
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
						<th>영화 제목</th>
						<th>배우 이름</th>
						<th>업데이트 날짜</th>
					</tr>
				</thead>
				<tbody> 
					<%
						for(FilmActorAndFilmAndActor f : list){
					%>
						<tr>
							<td><%=f.getFilm().getTitle() %></td>
							<td><%=f.getActor().getFirstName() + " " + f.getActor().getLastName()%></td>
							<td><%=f.getFilmActor().getLastUpdate() %></td>								
						</tr>
					<%
						}
					%>
				</tbody>
			</table>	
			
		<%
			if(list.isEmpty()){
				
			}else{
				
			
		%>
				<!-- 하단 페이징 작업 -->
		<ul class="pagination" style="justify-content: center;">
		<%
			if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
		<%
			}else{
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
		<%		
			}
		
			if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
		<%
			}else{
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmActorList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
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
							href="filmActorList.jsp?currentPage=<%=p.getPageNum()%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
						</li>
		<%
					}else{
		%>
						<li class="page-item"><a class="btn" style="background-color: #b8daff;"
							href="filmActorList.jsp?currentPage=<%=p.getPageNum()%>&searchWord=<%=searchWord%>"><%=p.getPageNum() %></a>						
						</li>
		<%
					}	
			}
		
			if(currentPage<lastPage){ //현재 페이지값이 lastPage보다 크거나 같으면 다음 버튼 임시 비활성화
		%>			
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
				</li>	
		<%		
			}else{
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="filmActorList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>
		<%
			}
		
			if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화 
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
		<%
			}else{
		%>
				<li class="page-item"><a class="btn" style="background-color: #b8daff;"
					href="filmActorList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
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