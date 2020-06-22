<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	LanguageDao languageDao = new LanguageDao();


	
	String name = request.getParameter("insertWord");
	System.out.println(name + "<--name");
	
	Language l = new Language();

	l.setName(name);
	

	languageDao.insertLanguage(l);
	
	response.sendRedirect(request.getContextPath()+"/language/languageList.jsp");
%>