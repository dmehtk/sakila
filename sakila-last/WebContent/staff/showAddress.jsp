<%@page import="java.util.HashMap"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	CityDao cityDao = new CityDao();
	ArrayList<City> cityList = cityDao.selectCityListAll();

	AddressDao addressDao = new AddressDao();
	
	
	if(request.getParameter("q") != null){	
		
		if(request.getParameter("q").equals("select")){
			//선택 없음
			
		}else if(request.getParameter("q").equals("userInput"))
		{
			//사용자가 직접 입력
%>
			<!-- 출력내용 -->
			<table class="table table-bordered table-hover">				
				<tbody>					
					<tr>
						<td>ADDRESS</td>
						<td><input class="form-control inputstl" type="text" name="address"></td>
					</tr>
					<tr>
						<td>ADDRESS 2</td>
						<td><input class="form-control inputstl" type="text" name="address2"></td>
					</tr>
					<tr>
						<td>DISTRICT</td>
						<td><input class="form-control inputstl" type="text" name="district"></td>
					</tr>
					<tr>
						<td>CITY ID</td>
						<td>
							<select class="form-control inputstl" name="cityId">
								<%
			    						for(City c : cityList){
			   					%>
			   							<option value="<%=c.getCityId()%>">
			   								<%=c.getCity() %>    							
			   							</option>
			   					<%
			   						}
			   					%>
							</select>
						</td>
					</tr>
					<tr>
						<td>POSTAL CODE</td>
						<td><input class="form-control inputstl" type="text" name="postalCode"></td>
					</tr>				
					
					<tr>
						<td>PHONE</td>
						<td><input class="form-control inputstl" type="text" name="phone"></td>
					</tr>
					
				</tbody>
			</table>

			
<%	
		}		
		else{
			//Address 가져오기
			System.out.println(request.getParameter("q"));
			
			HashMap<String, Object> address = new HashMap<String, Object>();			
			address = addressDao.selectAddressOne(Integer.parseInt(request.getParameter("q")));
			
%>
			<!-- 출력내용 -->
			<input type="hidden" name="cityId" value="<%=address.get("cityId")%>">
			<table class="table table-bordered table-hover">							
				<tbody>					
					<tr>
						<td>ADDRESS</td>						
						<td><input class="form-control inputstl" type="text" name="address" value="<%=address.get("address") %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>ADDRESS 2</td>						
						<td><input class="form-control inputstl" type="text" name="address2" value="<%=address.get("address2") %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>DISTRICT</td>						
						<td><input class="form-control inputstl" type="text" name="district" value="<%=address.get("district") %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>CITY ID</td>
						<td><input class="form-control inputstl" type="text" name="city" value="<%=address.get("city") %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>POSTAL CODE</td>						
						<td><input class="form-control inputstl" type="text" name="postalCode" value="<%=address.get("postalCode") %>" readonly="readonly"></td>
					</tr>				
					
					<tr>
						<td>PHONE</td>						
						<td><input class="form-control inputstl" type="text" name="phone" value="<%=address.get("phone") %>" readonly="readonly"></td>
					</tr>
					
				</tbody>
			</table>

<%
		}
	}

%>

	