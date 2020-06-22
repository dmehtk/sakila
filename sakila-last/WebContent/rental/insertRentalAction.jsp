<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="vo.*"%>

<%
	request.setCharacterEncoding("utf-8");
	
	RentalDao rentalDao = new RentalDao();
	
	Rental rental = new Rental();
	rental.setRentalDate(request.getParameter("rentalDate"));
	System.out.println(rental.getRentalDate() + "<--rentalDate");
	rental.setInventoryId(Integer.parseInt(request.getParameter("inventoryId")));
	System.out.println(rental.getInventoryId() + "<--inventoryId");
	rental.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
	System.out.println(rental.getCustomerId() + "<--customerId");
	rental.setStaffId(Integer.parseInt(request.getParameter("staffId")));
	System.out.println(rental.getStaffId() + "<--staffid");
	
	
	rentalDao.insertRental(rental);
	response.sendRedirect(request.getContextPath()+"/rental/rentalList.jsp");

%>