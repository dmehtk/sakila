<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>index</title>
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
        width: 210px;
        height: 3000px;
        position: fixed;
        background-color: white;
        overflow: hidden;
        float: left;
    }
    
    #section {
        margin-left: 200px;
        background-color: white;
    }
</style>
</head>
<body>
<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #d6d8db;"></div>   
    <div id="aside">
       <jsp:include page="/inc/sidemenu.jsp"></jsp:include>
    </div>
    <div id="section">
        <div class="container-fluid">
        	<h1 style="padding-top: 30px;">PROJECT INTRODUCE</h1>
        	<div class="row">
           	<!-- 사용된 언어 및 IDE -->
               <div class="col-xl-6 col-md-12">
                   <div class="card bg-primary {background-color : #FFA648} text-white mb-4" style="background-color : #FFA648">
                   
                       <div class="card-body">사용된 언어 및 IDE</div>
                       
                       <!-- 언어 -->
                       <div class="card-footer d-flex align-items-center justify-content-between">
                             <div>
                     <h6>사용된 언어</h6>
                            </div>
                           
                       </div>
                       
                       <!-- 언어내용소개 -->
                       <div class="card-footer d-flex align-items-center justify-content-between" style="border-top-width: 0px;">
                       
                             <div >
                     <img src="<%=request.getContextPath()%>/imgs/javaa.jpg" class="rounded-circle" style="width: 100px; height: 100px;">
                            <a>java</a>
                            </div>
                            <div >
                     <img src="<%=request.getContextPath()%>/imgs/html.jpg" class="rounded-circle" style="width: 100px; height: 100px;">
                            <a>HTML</a>
                            </div>
                            <div >
                     <img src="<%=request.getContextPath()%>/imgs/css2.png" class="rounded-circle" style="width: 100px; height: 100px;">
                            <a>CSS</a>
                             </div>
                       <div class="small text-white"></div>
                       </div>
                       
                        <!-- IDE -->
                       <div class="card-footer d-flex align-items-center justify-content-between">
                             <div>
                     <h6>사용된 IDE</h6>
                            </div>
                           
                       </div>
                       
                       <!-- IDE내용소개 -->
                       <div class="card-footer d-flex align-items-center justify-content-between" style="border-top-width: 0px;">
                             <div >
                     <img src="<%=request.getContextPath()%>/imgs/eclipse.jpg" class="rounded-circle" style="width: 100px; height: 100px;">
                            <a>Eclipse</a>
                            </div>
                       <div class="small text-white"></div>
                       </div>
                       
                       
                   </div>
               </div>
               
            <!--  사용된 DB -->   
               <div class="col-xl-6 col-md-12">
                   <div class="card bg-warning text-white mb-4">
                       <div class="card-body">사용된 DB</div>
                        <!-- sakila -->
                       <div class="card-footer d-flex align-items-center justify-content-between">
                             <div>
                     <h6>sakila</h6>
                            </div>
                           
                       </div>
                       
                       <!-- sakila내용소개 -->
                       <div class="card-footer d-flex align-items-center justify-content-between" style="border-top-width: 0px;">
                       
                             <div >
                     <a>▶ DVD대여점을 모델링한 Database입니다. </a>
                     <br>
                     <a>▶ 총 16개의 테이블, 7개의 뷰, 3개의 프로시저 , 6개의 트리거, 3개의 함수로 이루어져 있습니다.</a>
                     <br>
                     <a>▶ sakila 팀 프로젝트에서는 16개의 테이블을 영화 정보, 결제 정보, 가게 정보, 주소 정보 네가지 파트로 나누어서 구성하였습니다.</a>
                     <br>
                     <a>▶ 영화 정보에는 film,film_actor,film_category,film_text,launguage,actor,category 테이블
                     로 구성하였습니다.</a>
                     <br>
                     <a>▶ 결제 정보에는 payment,rental,customer 테이블로 구성하였습니다.</a>
                     <br>
                     <a>▶ 가게 정보에는 store, inventory,staff 테이블로 구성하였습니다.</a>
                     <br>
                             <a>▶ 주소 정보에는 address, city, country 테이블로 구성하였습니다.</a>
                     <br>
                             </div>
                             
                       <div class="small text-white"></div>
                       </div>
                   </div>
               </div>
               
        </div>     
        
          
        <div class="row">     
        
           <!-- 팀 구성(각자 쓰기) -->  
               <div class="col-xl-6 col-md-12">
                   <div class="card bg-success text-white mb-4">
                       <div class="card-body">팀 구성</div>
                       <div class="card-footer d-flex align-items-center justify-content-between">
                           <a>김서영, 김민정, 최지선, 송원혁, 정유석, 김종훈</a>
                           <div class="small text-white"></div>
                       </div>
                   </div>
               </div>
               
             <!-- 사용된 기술 서술 -->  
               <div class="col-xl-6 col-md-12">
                   <div class="card bg-danger text-white mb-4">
                       <div class="card-body">사용된 기술</div>
                       <div class="card-footer d-flex align-items-center justify-content-between">
                             <div>
                             <a>Vo,Dao,리스트로 나누어서 프로젝트를 구성</a><br>
		                     <a>sql쿼리를 활용한 Dao 생성</a><br>
		                     <a>Dao를 통한 리스트 생성</a><br>
		                     <a>INNER JOIN을 통한 테이블 생성</a><br>
		                     <a>INSERT FORM,INSERT ACTION으로 구성하여 테이블에 삽입을 가능하게 구성</a><br>
		                     <a>Dao에 모든 쿼리를 사용한 기능을 집어 넣어서 호출해서 사용할 수 있도록 구성</a><br>
		                     <a>각 리스트당 페이징 및 검색결과 페이징</a><br>
                     </div>
                           <div class="small text-white"></div>
                       </div>
                   </div>
               </div>
               
               
           </div>
        </div>
    </div>
</body>
</html>