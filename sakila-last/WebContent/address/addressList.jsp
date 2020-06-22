<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>ADDRESSLIST</title>
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
     		// 검색 비지니스 로직 
     		String searchWord = "";
     		int selectCityId = 0;
     		if(request.getParameter("searchWord") != null){
     			searchWord = request.getParameter("searchWord");
     		}
     		
     		//컨트롤 로직
     		AddressDao addressDao = new AddressDao();
     		ArrayList<AddressAndCityAndCountry> list;
     		
     		//페이징
     		int currentPage=1;
     		int rowPerPage=10;
     		if(request.getParameter("currentPage")!=null){
     			currentPage=Integer.parseInt(request.getParameter("currentPage"));
     		}
     		
     		int beginPage=(currentPage-1)*rowPerPage;
     		
     		int pagePerGroup=10;
			int groupStartPage=0;
     		
     		int totalRow=addressDao.selectTotalCount();
     		int lastPage=addressDao.selectLastPage(searchWord, rowPerPage);
     		
     		
     		//도시 선택시
     		if(request.getParameter("cityId") != null && request.getParameter("cityId") != ""){
     			selectCityId = Integer.parseInt(request.getParameter("cityId"));
     			list = addressDao.selectAddressList(selectCityId);
     			
     		}else{
     			//도시 선택 안했을시(전체) / 검색시
     			list = addressDao.selectAddressListAll(beginPage, rowPerPage, searchWord);
     		}
     	%>
        <h1 style="padding-top: 30px;">ADDRESS LIST</h1>
		<div>    
			<div id="accordion">
			    <div class="card">
			    	<!-- card header -->
			    	<div class="card-header" style="background-color: window;">
			        	<a class="card-link btn btn-outline-success" data-toggle="collapse" href="#collapseOne">
			          		검색  
			        	</a>
			        	<a class="collapsed card-link btn btn-outline-success" href="<%=request.getContextPath()%>/address/insertAddressForm.jsp">
				        	입력  
				      	</a>
			      	</div>
			      	<!-- card body -->				      
			      	<div id="collapseOne" class="collapse" data-parent="#accordion">
			        	<div class="card-body">
			        		<form method="post" action="<%=request.getContextPath()%>/address/addressList.jsp">
								<input class="form-control-plaintext" placeholder="주소 검색" type="text" name="searchWord" value="<%=searchWord%>">
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
						<th>주소 번호</th>
						<th>주소</th>
						<th>국가</th>
						<th>도시</th>
						<th>지역</th>
						<th>우편번호</th>
						<th>핸드폰</th>
						<th>마지막 업데이트</th>
					</tr>
				</thead>
				<tbody>
					<%		//출력
						for(AddressAndCityAndCountry acc : list){
					%>
					<tr>
						<td><%=acc.getAddress().getAddressId()%></td>
						<td><%=acc.getAddress().getAddress()%></td>
						<td><%=acc.getCountry().getCountry()%></td>
						<td><%=acc.getCity().getCity()%></td>
						<td><%=acc.getAddress().getDistrict()%></td>
						<td><%=acc.getAddress().getPostalCode()%></td>
						<td><%=acc.getAddress().getPhone()%></td>
						<td><%=acc.getAddress().getLastUpdate()%></td>
			
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
					href="addressList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%
				}else{  
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%		
				}
			
				if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
			<%
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
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
				<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/address/addressList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
				
			<%
					}else{
			%>
				<li class="page-item"><a class="btn" style="background-color:#c3e6cb;" href="<%=request.getContextPath() %>/address/addressList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
			<%
					}
				}
			%>
			<%
				if(currentPage < lastPage){
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
				</li>	
			<%		
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>
			<%
				}
			
				if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}else{
			%>
				<li class="page-item"><a class="btn" style="background-color: #c3e6cb;"
					href="addressList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}
			%>
			</ul>	
        </div>
	</div>  
</body>
</html>

