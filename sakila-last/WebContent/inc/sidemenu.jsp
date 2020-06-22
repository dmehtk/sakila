<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
         CountryDao countryDao = new CountryDao();
         CityDao cityDao = new CityDao();
         AddressDao addressDao = new AddressDao();
%>
<br>
<h5>&nbsp;&nbsp;LIST MENU</h5>
<br>
<ul style="padding-inline-start: 10px">

         <!-- home  -->
         <li class="list-group-item list-group-item-secondary">
            <a href="<%=request.getContextPath()%>/index.jsp" class="nav-link text text-secondary">
               HOME
            </a>      
         </li>
         
         
         <!-- FILM 관련 테이블 묶음(언어) -->
         <li class="nav-item dropdown list-group-item list-group-item-primary">
            <a class="nav-link dropdown-toggle text text-secondary" href="#" id="navbardrop" data-toggle="dropdown">
             FILM 정보
            </a>
            <div class="dropdown-menu">
               <a class="dropdown-item" href="<%=request.getContextPath()%>/film/filmList.jsp">FILM</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/filmActor/filmActorList.jsp">FILM ACTOR</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/filmCategory/filmCategoryList.jsp">FILM CATEGORY</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/filmText/filmTextList.jsp">FILM TEXT</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/language/languageList.jsp">LANGUAGE</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/actor/actorList.jsp">ACTOR</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/category/categoryList.jsp">CATEGORY</a>
            </div>
         </li>
          
          
          <!-- 결제 관련 테이블 묶음(payment:rental, customer, staff) -->
          <li class="nav-item dropdown list-group-item list-group-item-danger">
            <a class="nav-link dropdown-toggle text text-secondary" href="#" id="navbardrop" data-toggle="dropdown">
             결제 정보
            </a>
            <div class="dropdown-menu">
               <a class="dropdown-item" href="<%=request.getContextPath()%>/payment/paymentList.jsp">PAYMENT</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/rental/rentalList.jsp">RENTAL</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/customer/customerList.jsp">CUSTOMER</a>
            </div>
         </li>
          <!-- store 관련 테이블 묶음(store:inventory,customer ,staff,address) -->
          <li class="nav-item dropdown list-group-item list-group-item-warning">
            <a class="nav-link dropdown-toggle text text-secondary" href="#" id="navbardrop" data-toggle="dropdown">
            가게 정보
            </a>
            <div class="dropdown-menu">
               <a class="dropdown-item" href="<%=request.getContextPath()%>/store/storeList.jsp">STORE</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/inventory/inventoryList.jsp">INVETORY</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/staff/staffList.jsp">STAFF</a>
            </div>
         </li>
         
         
         <!-- ADDRESS 관련 테이블 묶음 -->
          <li class="nav-item dropdown list-group-item list-group-item-success">
            <a class="nav-link dropdown-toggle text text-secondary" href="#" id="navbardrop" data-toggle="dropdown">
             주소 정보
            </a>
            <div class="dropdown-menu">
               <a class="dropdown-item" href="<%=request.getContextPath()%>/address/addressList.jsp">ADDRESS</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/city/cityList.jsp">CITY</a>
               <a class="dropdown-item" href="<%=request.getContextPath()%>/country/countryList.jsp">COUNTRY</a>
            </div>
         </li>
    </ul>  
        