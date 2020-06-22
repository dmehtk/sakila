<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//form에서 값 가져오기
	int film = Integer.parseInt(request.getParameter("film"));
	System.out.println(film+"<--film");
	
	int storeId = Integer.parseInt(request.getParameter("storeId"));
	System.out.println(storeId+"<--storeId");
	
	//공간 선언
	Inventory inventory = new Inventory();
	inventory.setFilmId(film);
	inventory.setStoreId(storeId);
	
	//Dao
	InventoryDao inventoryDao = new InventoryDao();
	inventoryDao.insertInventory(inventory);
	
	//리스트로 보내주기
	response.sendRedirect(request.getContextPath()+"/inventory/inventoryList.jsp");
%>