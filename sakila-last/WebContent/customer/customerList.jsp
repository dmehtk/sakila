<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>CUSTOMERLIST</title>
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
<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #f5c6cb;"></div>
    <div id="aside">
    	<jsp:include page="/inc/sidemenu.jsp"></jsp:include>
    </div>

    <div id="section">
        <div>
            <%
            	//검색 비지니스 로직
            	String searchWord = "";
            	if(request.getParameter("searchWord") != null){
            		searchWord = request.getParameter("searchWord");            		
            	}
            	
            	//컨트롤 로직
				CustomerDao customerDao = new CustomerDao();
				ArrayList<Customer> list = customerDao.selectCustomerList(searchWord);
				
				
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
				//customerId 선택했을 경우
    	    	if(request.getParameter("customerId")!=null && request.getParameter("customerId")!=""){
    	    		searchCustomerId = Integer.parseInt(request.getParameter("customerId"));
    	    		list = customerDao.selectCustomerAll(searchCustomerId);
    	    	}else{
    	    		
    	    		list = customerDao.selectCustomerList(searchWord);
    	    		
    	    		
    	    		lastPage  = customerDao.selectLastPage(searchWord, rowPerPage);
    	    		beginRow = (currentPage-1) * rowPerPage;	//1page = 0~9	2page=10~19
    	    		list = customerDao.selectCustomerList(searchWord, beginRow, rowPerPage);
    	    	}
				
				
				
    		%>
			<h1 style="padding-top: 30px;">CUSTOMER LIST</h1>
			 <div>    
				<div id="accordion">
				    <div class="card">
				    	<!-- card header -->
				      <div class="card-header" style="background-color: window;">
				        <a class="card-link btn btn-outline-danger" data-toggle="collapse" href="#collapseOne">
				          	검색  
				        </a>
				        <a class="collapsed card-link btn btn-outline-danger" href="<%=request.getContextPath()%>/customer/insertCustomerForm.jsp">
				        	입력  
				      	</a>
				      </div>
				      <!-- card body -->				      
				      <div id="collapseOne" class="collapse" data-parent="#accordion">
				        <div class="card-body">
				        	<form method="post" action="<%=request.getContextPath()%>/customer/customerList.jsp">
								<input class="form-control-plaintext" placeholder="고객 이름" type="text" name="searchWord" value="<%=searchWord%>">
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
						<th>CUSTOMER_ID</th>
						<th>STORE_ID</th>
						<th>FULL_NAME</th>
						<th>EMAIL</th>
						<th>ADDRESS_ID</th>
						<th>ACTIVE</th>
						<th>CREATE_DATE</th>
						<th>LAST_UPDATE</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Customer c : list){
					%>
						<tr>
							<td><%=c.getCustomerId()%></td>
							<td><%=c.getStoreId()%></td>
							<td><%=c.getFullName()%></td>
							<td><%=c.getEmail()%></td>
							<td><%=c.getAddressId()%></td>
							<td><%=c.getActive()%></td>
							<td><%=c.getCreateDate()%></td>
							<td><%=c.getLastUpdate()%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
		<%
			if(searchCustomerId != 0){
				
			}else{
			
		%>
	
		<!-- 하단 페이징 작업 -->
		<ul class="pagination justify-content-center">		
			<%
				if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
			%>	
				<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%
				}else{  
			%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
			<%		
				}
			
				if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
			%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
			<%
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
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
				<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
				
			<%
					}else{
			%>
				<li class="page-item"><a class="btn" style="background-color:#f5c6cb;" href="<%=request.getContextPath() %>/customer/customerList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
			<%
					}
				}
			%>
			<%
				if(currentPage < lastPage){
			%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
				</li>	
			<%		
				}else{
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
				</li>
			<%
				}
			
				if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
			%>
				<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}else{
			%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="customerList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
				</li>
			<%
				}
			}
			%>
		</ul>
			
			
			</div>
		</div>
	</div>    
</body>
</html>



