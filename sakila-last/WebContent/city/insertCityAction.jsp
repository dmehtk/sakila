<%@page import="vo.City"%>
<%@page import="dao.CityDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//인코딩 
	request.setCharacterEncoding("utf-8");

	
	String city=request.getParameter("cityName");
	System.out.println(city+"<--city");
	
	int countryId=Integer.parseInt(request.getParameter("countryId"));
	System.out.println(countryId+"<--countryId");
	
	//공간 선언
	City c=new City();
	c.setCity(city);
	c.setCountryId(countryId);
	
	//Dao호출
	CityDao cityDao = new CityDao();
	cityDao.insertCity(c);
	
	//리스트로 보내주기
	response.sendRedirect(request.getContextPath()+"/city/cityList.jsp");
%>
