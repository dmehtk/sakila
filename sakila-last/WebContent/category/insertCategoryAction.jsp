<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "vo.*" %> 
<%@ page import = "dao.*" %> 
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	System.out.println(name+"<--nameinsert");
	
	Category category = new Category();
	category.setName(name);
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>