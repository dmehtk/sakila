<%@page import="dao.StaffDao"%>
<%@page import="vo.Address"%>
<%@page import="vo.Staff"%>
<%@page import="dao.AddressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	AddressDao addressDao = new AddressDao();
	StaffDao staffDao = new StaffDao();
	
	Address address = new Address();
	
	int addressId = 0;
	
	if(request.getParameter("selectAddress").equals("select")){
		//Address 선택 안함
		
		response.sendRedirect(request.getContextPath()+"/staff/insertStaffForm.jsp");
		return;
	}else if(request.getParameter("selectAddress").equals("userInput")){
		//Address 새로 추가
		address.setAddress(request.getParameter("address"));
		address.setAddress2(request.getParameter("address2"));
		address.setDistrict(request.getParameter("district"));
		address.setCityId(Integer.parseInt(request.getParameter("cityId")));
		address.setPostalCode(request.getParameter("postalCode"));
		address.setPhone(request.getParameter("phone"));
		
		addressId = addressDao.insertAddressAndSelectKey(address);	
	}else{
		//Address 기존 정보 사용
		//System.out.println("번호 : " + request.getParameter("selectAddress")); 
		addressId = Integer.parseInt(request.getParameter("selectAddress"));
	}
		
		
	
	Staff staff = new Staff();
	staff.setFirstName(request.getParameter("firstName"));
	staff.setLastName(request.getParameter("lastName"));
	staff.setAddressId(addressId);
	staff.setEmail(request.getParameter("email"));
	staff.setStoreId(Integer.parseInt(request.getParameter("storeId")));
	
	staff.setUsername(request.getParameter("userName"));
	staff.setPassword(request.getParameter("password"));
	
	staffDao.insertStaff(staff);
	
	response.sendRedirect(request.getContextPath()+"/staff/staffList.jsp");
%>