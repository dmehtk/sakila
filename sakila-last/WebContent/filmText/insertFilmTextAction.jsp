<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	
	request.setCharacterEncoding("utf-8");
	
	FilmTextDao filmTextDao = new FilmTextDao();
	FilmText filmText = new FilmText();
	
	filmTextDao.selectFilmTextIdMax();
	
	String title = request.getParameter("title");
	System.out.println(title+"<---title Action");
	String description = request.getParameter("description");
	System.out.println(description+"<---description Action");
	
	filmText.setTitle(title);
	filmText.setDescription(description);
	
	filmTextDao.insertFilmText(filmText);
	
	response.sendRedirect(request.getContextPath()+"/filmText/filmTextList.jsp");
%>
