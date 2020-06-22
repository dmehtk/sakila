<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>PAYMENTLIST</title>
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
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #f5c6cb;">
	</div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include> 
    </div>
    <div id="section">
    	<div>
			<%
				request.setCharacterEncoding("utf-8");
			
				PaymentDao paymentDao = new PaymentDao();
				
				String searchWord = "";
				
				if(request.getParameter("searchWord") != null){
				searchWord = request.getParameter("searchWord");
				}
				
				//페이징 로직
				//페이지 번호 초기값
				int currentPage = 1;
				if(request.getParameter("currentPage") != null){
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				// 한 페이지당 행의 수
				int rowPerPage = 10;
				// 0~99 , 100~199 , 200~299 
				if(request.getParameter("rowPerPage") != null){
					rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
				}
				int beginRow = (currentPage-1)*rowPerPage;
				//행의 총갯수
				int totalCount = paymentDao.totalCount();
				// 마지막 페이지 
				int lastPage = paymentDao.selectLastPage(searchWord, rowPerPage);
				//페이지 그룹 수
				int pagePerGroup = 10;
				
				ArrayList<PaymentAndCustomerAndStaff> list = paymentDao.selectPaymentAndCustomerAndStaffAll(searchWord, beginRow, rowPerPage);
			%>
	        <h1 style="padding-top: 30px;">PAYMENT LIST</h1>
	 		<div>     
		 	<!-- 검색, 입력 출력 -->
				<div>    
					<div id="accordion">
					    <div class="card">
					    	<!-- card header -->
					      	<div class="card-header" style="background-color: window;">
					        	<a class="card-link btn btn-outline-danger" data-toggle="collapse" href="#collapseOne">
					        	  	검색  
					        	</a>
					      	</div>
					      	<!-- card body -->				      
					      	<div id="collapseOne" class="collapse" data-parent="#accordion">
					        	<div class="card-body">
					        		<form method="post" action="<%=request.getContextPath()%>/payment/paymentList.jsp">
										<input class="form-control-plaintext" placeholder="지불 번호" type="text" name="searchWord" value="<%=searchWord%>">
										<br>
										<button type="submit" class="btn btn-outline-light text-dark">Go</button>
									</form>
					        	</div>
					      	</div>
					    </div>
					</div>
				</div>
	    		<br>
				<table border="1" class="table table-bordered table-hover">
					<thead class="thead-light">
						<tr>
							<th>지불 번호</th>
							<th>고객 이름</th>
							<th>직원 이름</th>
							<th>대여 번호</th>
							<th>요금 합계</th>
							<th>요금지불날짜</th>
							<th>업데이트 날짜</th>
						</tr>
					</thead>
					<tbody>
						<%
							for(PaymentAndCustomerAndStaff pacas : list) {
						%>
						<tr>
							<td><%=pacas.getPayment().getPaymentId()%></td>
							<td>
									<%=pacas.getCustomer().getFirstName() + " " + pacas.getCustomer().getLastName()%> 
							</td>
							<td><%=pacas.getStaff().getUsername() %></td>
							<td>
									<%=pacas.getPayment().getRentalId() %>
							</td>
							<td><%=pacas.getPayment().getAmount() %></td>
							<td><%=pacas.getPayment().getPaymentDate() %></td>
							<td><%=pacas.getPayment().getLastUpdate() %></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<ul class="pagination justify-content-center">		
					<%
						if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
					%>	
						<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
							href="paymentList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
						</li>
					<%
						}else{  
					%>
							<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
								href="paymentList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
							</li>
					<%		
						}
					
						if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
					%>
							<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
								href="paymentList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
							</li>			
					<%
						}else{
					%>
							<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
								href="paymentList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
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
						<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/payment/paymentList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
						
					<%
							}else{
					%>
						<li class="page-item"><a class="btn" style="background-color:#f5c6cb;" href="<%=request.getContextPath() %>/payment/paymentList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
					<%
							}
						}
					%>
					<%
						if(currentPage < lastPage){
					%>
						<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
							href="paymentList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
						</li>	
					<%		
						}else{
					%>
						<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
								href="paymentList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
						</li>
					<%
						}
					
						if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
					%>
						<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
							href="paymentList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
						</li>
					<%
						}else{
					%>
						<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
							href="paymentList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
						</li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>