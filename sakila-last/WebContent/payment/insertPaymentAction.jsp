<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	//값 가져오기
	int customerName = Integer.parseInt(request.getParameter("customerName"));
	System.out.println(customerName+"<--customerName");
	int username = Integer.parseInt(request.getParameter("username"));
	System.out.println(username+"<--username");
	int rentalId = Integer.parseInt(request.getParameter("rentalId"));
	System.out.println(rentalId+"<--rentalId");

	
	float amount = Float.parseFloat(request.getParameter("amount"));
	System.out.println(amount+"<--amount");
	
	//공간 선언
	Payment payment = new Payment();
	payment.setCustomerId(customerName);
	payment.setStaffId(username);
	payment.setRentalId(rentalId);
	payment.setAmount(amount);
	//Dao
	PaymentDao paymentDao = new PaymentDao();
	paymentDao.insertPayment(payment);
	
	//리스트로 보내기
	response.sendRedirect(request.getContextPath()+"/payment/paymentList.jsp");
%>