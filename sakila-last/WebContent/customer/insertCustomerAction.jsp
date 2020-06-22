<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	
	CustomerDao customerDao = new CustomerDao();

	
	Customer customer = new Customer();
	customer.setStoreId(Integer.parseInt(request.getParameter("storeId")));
	
	customer.setFirstName(request.getParameter("firstName"));
	customer.setLastName(request.getParameter("lastName"));
	customer.setEmail(request.getParameter("email"));
	customer.setAddressId(Integer.parseInt(request.getParameter("addressId")));
	customer.setCreateDate(request.getParameter("createDate"));
	
	customerDao.insertCustomer(customer);
	
	response.sendRedirect(request.getContextPath()+"/customer/customerList.jsp");

%>