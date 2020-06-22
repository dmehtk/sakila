<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String address = request.getParameter("address");
	String address2 = request.getParameter("address2");
	String district = request.getParameter("district");
	int cityId = Integer.parseInt(request.getParameter("cityId"));
	String postalCode = request.getParameter("postalCode");
	String phone = request.getParameter("phone");
	String lastUpdate = request.getParameter("lastUpdate");
	
	Address addr = new Address();
	addr.setAddress(address);
	addr.setAddress2(address2);
	addr.setDistrict(district);
	addr.setCityId(cityId);
	addr.setPostalCode(postalCode);
	addr.setPhone(phone);
	addr.setLastUpdate(lastUpdate);
	
	
	
	AddressDao addressDao = new AddressDao();
	addressDao.insertAdrress(addr);
	response.sendRedirect(request.getContextPath()+"/address/addressList.jsp");
%>