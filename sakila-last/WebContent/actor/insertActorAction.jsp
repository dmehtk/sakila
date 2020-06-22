<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>


<%
	request.setCharacterEncoding("utf-8");

	Actor actor = new Actor();
	ActorDao actorDao = new ActorDao();
	
	
	String firstName = request.getParameter("firstName");
	System.out.println(firstName+"<<<< firstname");
	String lastName = request.getParameter("lastName");
	System.out.println(lastName+"<<< lastname");
	
	actor.setFirstName(firstName);
	actor.setLastName(lastName);
	
	actorDao.insertActor(actor);
	response.sendRedirect(request.getContextPath()+"/actor/actorList.jsp");
%>
