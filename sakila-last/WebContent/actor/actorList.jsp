<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>ACTORLIST</title>
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
            	ActorDao actorDao = new ActorDao();
            	//검색값 확인
            	String searchWord = "";
            	if(request.getParameter("searchWord") != null){
            		searchWord = request.getParameter("searchWord");            		
            	}
            	
            	int currentPage = 1;
            	if(request.getParameter("currentPage") != null){
            		currentPage = Integer.parseInt(request.getParameter("currentPage"));
            	}
            	int rowPerPage = 10;
            	if(request.getParameter("rowPerPage") != null){
            		currentPage = Integer.parseInt(request.getParameter("rowPerPage"));
            	}
            	
            	int beginRow = (currentPage-1)*rowPerPage;
            	
            	int totalPage = actorDao.totalCount();
            	int lastPage = actorDao.selectLastPage(searchWord, rowPerPage);
            	
            	int pagePerGroup = 10;
            	int pagePerGRroupStart = 1;
            	
            	//컨트롤 로직
				ArrayList<Actor> list = actorDao.selectActorList(searchWord, beginRow, rowPerPage);
			%>
			<h1 style="padding-top: 30px;">ACTOR LIST</h1>
			 <!-- 검색, 입력 출력 -->
			<div>    
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
					        	<form method="post" action="<%=request.getContextPath()%>/actor/actorList.jsp">
									<input class="form-control-plaintext" placeholder="배우 이름" type="text" name="searchWord" value="<%=searchWord%>">
									<br>
									<button type="submit" class="btn btn-outline-light text-dark">Go</button>
								</form>
					        </div>
					    </div>
			 		 	<div id="collapseTwo" class="collapse" data-parent="#accordion">
					        <div class="card-body">
					        	<form method="post" action="<%=request.getContextPath()%>/actor/insertActorAction.jsp">				        		
									FIRST_NAME :
									<input  class="form-control" type="text" name="firstName">
									LAST_NAME : 
									<input  class="form-control" type="text" name="lastName">
									<br>
									<button type="submit" class="btn btn-outline-light text-dark">Go</button>
								</form>
					        </div>
					    </div>
				    </div>
				</div>
			</div>
    		<br>
			<table class="table table-bordered table-hover">
				<thead class="thead-light">
					<tr>
						<th>배우번호</th>
						<th>배우이름</th>
						<th>업데이트 날짜</th>
					</tr>
				</thead>
				<tbody id="myTable">
					<%
						for(Actor a : list){
					%>
						<tr>
							<td><%=a.getActorId()%></td>
							<td><%=a.getFirstName() + " " + a.getLastName()%></td>
							<td><%=a.getLastUpdate()%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<ul class="pagination" style="justify-content: center;">
			<%
				if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
			%>	
				<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
					href="actorList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%
				}else{
			%>
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="actorList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
					</li>
			<%		
				}
			
				if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
			%>
					<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="actorList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
					</li>			
			<%
				}else{
			%>
					<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
						href="actorList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
					</li>
	       	<%
				}
			%>
				<%//세부 페이징
					Paging paging = new Paging();
					PagingDao pagingDao = new PagingDao();
					ArrayList<Paging> plList = pagingDao.groupPaging(currentPage, pagePerGroup, lastPage);
					
					for(Paging pa : plList){
						if(pa.getPageSelect() == true){ // 현재 페이지는  true 그 이외의 페이지는 false , 즉 현재페이지만 다른 색으로 구분해줌
				%>
					<li class="page-item"><a class="btn page-link" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/actor/actorList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
					
				<%
						}else{
				%>
					<li class="page-item"><a class="btn btn-outline-danger page-link" style="background-color: #b8daff;" href="<%=request.getContextPath() %>/actor/actorList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
				<%
						}
					}
				%>
				<%
					if(currentPage < lastPage){ //현재 페이지값이 lastPage보다 크거나 같으면 다음 버튼 임시 비활성화
				%>
						<li class="page-item"><a class="btn" style="background-color: #b8daff;"
						href="actorList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
					</li>	
				<%		
					}else{
				%>
						<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
								href="actorList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
						</li>
				<%
					}
				
					if(currentPage >= lastPage){ // 현재 페이지값이 lastPage과 같으면 마지막 버튼 임시 비활성화
				%>
						<li class="page-item"><a class="btn disabled" style="background-color: #b8daff;"
							href="actorList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
						</li>
				<%
					}else{
				%>
						<li class="page-item"><a class="btn" style="background-color: #b8daff;"
							href="actorList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
						</li>
				<%
					}
				%>
			</ul>
		</div>
	</div>    
</body>
</html>



