<%@page import="vo.Country"%>
<%@page import="dao.CountryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//입력할 국가의 countryId 자동 설정 (countryId 최대값 + 1)
	CountryDao countryDao = new CountryDao();
	Country country = new Country();
	
	String insertCountry = "";
	
	//입력할 국가 번호 자동생성
	country.setCountryId(countryDao.selectCountryIdMax());
	
	//입력할 국가 이름
	if(request.getParameter("insertWord") != "" && request.getParameter("insertWord") != null){
		country.setCountry(request.getParameter("insertWord"));		
	}else{
		response.sendRedirect(request.getContextPath() + "/country/countryList.jsp");
		return;
	}
	
	//DB 입력
	countryDao.insertCountry(country);
	
	response.sendRedirect(request.getContextPath() + "/country/countryList.jsp");
%>