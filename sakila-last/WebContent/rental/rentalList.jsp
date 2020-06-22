<%@page import="javax.servlet.jsp.tagext.PageData"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">   
<title>RANTALLIST</title>
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
   <%
   
   request.setCharacterEncoding("utf-8");   
   
   
   //페이징
   int currentPage=1;
   if(request.getParameter("currentPage")!=null){
      currentPage=Integer.parseInt(request.getParameter("currentPage"));
   }
   int rowPerPage=10;
   int beginPage=(currentPage-1)*rowPerPage;
   

   
   
   //검색
   String searchWord = "";
   
   if(request.getParameter("searchWord") != null){
      searchWord = request.getParameter("searchWord");
   }
   
   //totalRow
   RentalDao rentalDao = new RentalDao();
   //int totalRow=rentalDao.selectTotlaCount(searchWord);
   //int lastPage=rentalDao.selectLastPage(searchWord, rowPerPage);
		int totalRow = 0;
		int lastPage = 0;

  
   
   ArrayList<RentalAndStaff> list = new ArrayList<RentalAndStaff>();
   int searchWordRentalId = 0;

   
   
   //ID 클릭해서 왔을시
   if(request.getParameter("rentalId") != null && request.getParameter("rentalId") != ""){
	   list = rentalDao.selectRentalAndStaffsearch(beginPage, rowPerPage, Integer.parseInt(request.getParameter("rentalId")));
 	totalRow = rentalDao.selectTotlaCount(Integer.parseInt(request.getParameter("rentalId")));
 	lastPage = rentalDao.selectLastPage(Integer.parseInt(request.getParameter("rentalId")), rowPerPage);
   }else{
 	  //그외
 	  list = rentalDao.selectRentalAndStaff(beginPage, rowPerPage, searchWord);
 	  totalRow = rentalDao.selectTotlaCount(searchWord);
 	  lastPage = rentalDao.selectLastPage(searchWord, rowPerPage);
   }
   %>
        <h1 style="padding-top: 30px;">RENTAL LIST</h1>
      <!-- 검색, 입력 출력 -->
         <div>    
            <div id="accordion">
                <div class="card">
                   <!-- card header -->
                  <div class="card-header" style="background-color: window;">
                    <a class="card-link btn btn-outline-danger" data-toggle="collapse" href="#collapseOne">
                         	검색  
                    </a>
                    <a class="collapsed card-link btn btn-outline-danger" href="<%=request.getContextPath()%>/rental/insertRentalForm.jsp">
				        	입력  
				    </a>   
                   </div>
                  
                  
                  <!-- card body -->                  
                  <div id="collapseOne" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                       <form method="post" action="<%=request.getContextPath()%>/rental/rentalList.jsp">
                        <input class="form-control" type="text" name="searchWord" value="<%=searchWord%>">
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
            <th>대여 번호</th>
			<th>대여 날짜</th>
			<th>목록 번호</th>
			<th>고객 번호</th>
			<th>반납 날짜와 시간</th>
			<th>대여를 처리한 직원</th>
			<th>업데이트 날짜</th>
			<th>반납 정보 입력</th>
         </tr>
         </thead>
         <tbody>
            <%
               for(RentalAndStaff ras : list) {
            %>
            <tr>
               <td><%=ras.getRental().getRentalId()%></td>
               <td><%=ras.getRental().getRentalDate() %></td>
               <td>
                  	<%=ras.getRental().getInventoryId() %>
               	</td>
               	<td>
                  		<%=ras.getRental().getCustomerId() %>
               	</td>
               	<td><%=ras.getRental().getReturnDate() %></td>
               	<td><%=ras.getStaff().getUsername() %></td>
               	<td><%=ras.getRental().getLastUpdate() %></td>
	 			<td><a href="<%=request.getContextPath()%>/payment/insertPaymentForm.jsp?rentalId=<%=ras.getRental().getRentalId()%>">반납 정보 입력</a></td>
            </tr>
         </tbody>
            <%
               }
            %>
      </table>
      
      <!-- 페이징 -->
		<ul class="pagination justify-content-center">		
		<%
			if(currentPage == 1){ //현재 페이지 값이 1 이면 첫번째 버튼 임시 비활성화
		%>	
			<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
				href="rentalList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
			</li>
		<%
			}else{  
		%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="rentalList.jsp?currentPage=1&searchWord=<%=searchWord%>">첫번째</a>						
				</li>
		<%		
			}
		
			if(currentPage>1){ //현재 페이지값이 1보다 작거나 같으면 이전 버튼 비활성화
		%>
				<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
					href="rentalList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>						
				</li>			
		<%
			}else{
		%>
				<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="rentalList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전</a>						
				</li>
       	<%
			}
		%>
		<%//세부 페이징
			int pagePerGroup=10;
	  	    int groupStartPage=0;
			Paging paging = new Paging();
			PagingDao pagingDao = new PagingDao();
			ArrayList<Paging> plList = pagingDao.groupPaging(currentPage, pagePerGroup, lastPage);
			
			for(Paging pa : plList){
				if(pa.getPageSelect() == true){
		%>
			<li class="page-item"><a class="btn" style="background-color: #e9ecef;" href="<%=request.getContextPath() %>/rental/rentalList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
			
		<%
				}else{
		%>
			<li class="page-item"><a class="btn" style="background-color:#f5c6cb;" href="<%=request.getContextPath() %>/rental/rentalList.jsp?currentPage=<%=pa.getPageNum()%>&searchWord=<%=searchWord%>"><%=pa.getPageNum()%></a></li>
		<%
				}
			}
		%>
		<%
			if(currentPage < lastPage){
		%>
			<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
				href="rentalList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>						
			</li>	
		<%		
			}else{
		%>
			<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
					href="rentalList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>">다음</a>						
			</li>
		<%
			}
		
			if(currentPage >= lastPage){ //현재 페이지값이  lastPage와 같으면 다음 버튼과 마지막 버튼 임시 비활성화  
		%>
			<li class="page-item"><a class="btn disabled" style="background-color: #f5c6cb;"
				href="rentalList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
			</li>
		<%
			}else{
		%>
			<li class="page-item"><a class="btn" style="background-color: #f5c6cb;"
				href="rentalList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>						
			</li>
		<%
			}
		%>
	</ul>
   </div>
</body>
</html>