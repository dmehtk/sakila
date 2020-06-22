package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import util.*;

public class CityDao {
	
	// total count 값 구하기
	public int totalCount() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT count(*) from sakila_city";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("count(*)");
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return totalCount;
	}
	//last page 값 구하기
	public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
	     
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			int totalPage = 0;
			try {
				 DBUtil dbUtil = new DBUtil();
			      conn = dbUtil.getConnection();
			      String sql = "SELECT count(*) FROM sakila_city ci INNER JOIN sakila_country co ON ci.country_id = co.country_id WHERE ci.city LIKE ? OR co.country LIKE ?";
			      stmt = conn.prepareStatement(sql);
			      stmt.setString(1, "%"+searchWord+"%");
			      stmt.setString(2, "%"+searchWord+"%");
			      rs = stmt.executeQuery();

			      int staffCount = 0;
			      if(rs.next()) {
			         staffCount = rs.getInt("count(*)");
			      }         
			      
			      
			      if(staffCount % rowPerPage == 0) {
			         totalPage = staffCount / rowPerPage;
			      }else {
			         totalPage = (staffCount / rowPerPage) + 1;
			      }
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally {
				try {
					conn.close();
					stmt.close();
					rs.close();
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
	      return totalPage;
	   }
	//insertCityForm에서 입력한 값을 가지고 와 insert
	public City insertCity(City city) throws Exception{
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO sakila_city(city, country_id, last_update) VALUES(?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);		
		stmt.setString(1, city.getCity());
		stmt.setInt(2, city.getCountryId());
		stmt.executeQuery();
		
		return city;
	}
	
	public ArrayList<City> selectCityListAll() throws Exception{
		
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<City> list = new ArrayList<City>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT city_id, city FROM sakila_city";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				City city = new City();
				city.setCityId(rs.getInt("city_id"));
				city.setCity(rs.getString("city"));
				list.add(city);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return list;
	}	
	//serchWord에 따라 리스트 불러와 출력 select
	public ArrayList<CityAndCountry> selectCityAndCountryAll(String searchWord, int beginRow, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<CityAndCountry> list = new ArrayList<CityAndCountry>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT ci.*, co.* FROM sakila_city ci INNER JOIN sakila_country co ON ci.country_id = co.country_id" + 
					" WHERE ci.city LIKE ? OR co.country LIKE ? ORDER BY ci.city_id LIMIT ?,?"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,"%"+searchWord+"%");
			stmt.setString(2,"%"+searchWord+"%");
			stmt.setInt(3, beginRow);
			stmt.setInt(4, rowPerPage);
			rs = stmt.executeQuery();
			
			//RresultSet을 ArrayList로 바꿔줌
			while(rs.next()) {
				//City클래스 와 Country클래스를 넣어줄 공간을 만듦
				CityAndCountry cc = new CityAndCountry();
				
				//City클래스 불러와서 쿼리 값 집어넣음
				City city = new City();
				city.setCityId(rs.getInt("city_id"));
				city.setCity(rs.getString("city"));
				city.setCountryId(rs.getInt("city_id"));
				city.setLastUpdate(rs.getString("city_id"));
				
				//넣어준 값을 cc에 넣어줌
				cc.setCity(city);
				
				//Country 클래스를 불러와서 쿼리 값을 집어넣음
				Country country = new Country();
				country.setCountryId(rs.getInt("country_id"));
				country.setCountry(rs.getString("country"));
				country.setLastUpdate(rs.getString("last_update"));
				
				//넣어줌 값을 cc에 넣어줌
				cc.setCountry(country);
				
				//country와 city를 넣은 cc를 최종적으로 list에 넣어줌 
				list.add(cc);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	
	//serchWord에 따라 리스트 불러와 출력 select
	public ArrayList<CityAndCountry> selectCityAndCountry(int searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<CityAndCountry> list = new ArrayList<CityAndCountry>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT ci.*, co.* FROM sakila_city ci INNER JOIN sakila_country co ON ci.country_id = co.country_id" + 
					" WHERE ci.country_id = ? ORDER BY ci.city_id "; 
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,searchWord);		
			rs = stmt.executeQuery();
			
			//RresultSet을 ArrayList로 바꿔줌
			while(rs.next()) {
				//City클래스 와 Country클래스를 넣어줄 공간을 만듦
				CityAndCountry cc = new CityAndCountry();
				
				//City클래스 불러와서 쿼리 값 집어넣음
				City city = new City();
				city.setCityId(rs.getInt("city_id"));
				city.setCity(rs.getString("city"));
				city.setCountryId(rs.getInt("city_id"));
				city.setLastUpdate(rs.getString("city_id"));
				
				//넣어준 값을 cc에 넣어줌
				cc.setCity(city);
				
				//Country 클래스를 불러와서 쿼리 값을 집어넣음
				Country country = new Country();
				country.setCountryId(rs.getInt("country_id"));
				country.setCountry(rs.getString("country"));
				country.setLastUpdate(rs.getString("last_update"));
				
				//넣어줌 값을 cc에 넣어줌
				cc.setCountry(country);
				
				//country와 city를 넣은 cc를 최종적으로 list에 넣어줌 
				list.add(cc);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return list;
	}
		
	public int selectCityIdMax() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int cityIdMax = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT MAX(city_id) FROM sakila_city";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			
			if(rs.next()) {
				cityIdMax = (rs.getInt("MAX(city_id)")) + 1;
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return cityIdMax;
	}
	
}
