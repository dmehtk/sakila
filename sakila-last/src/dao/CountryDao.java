package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Country;

public class CountryDao {
	
	//국가 리스트
	public ArrayList<Country> selectCountryListAll(String searchWord) throws Exception{
		System.out.println(searchWord + " <-- searchWord");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Country> list = new ArrayList<Country>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT * FROM sakila_country WHERE country like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				Country country = new Country();
				country.setCountryId(rs.getInt("country_id"));
				country.setCountry(rs.getString("country"));
				country.setLastUpdate(rs.getString("last_update"));			
				list.add(country);
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
	
	//입력할 국가 번호 자동으로 확인
	public int selectCountryIdMax() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int countryIdMax = 0;
		try {
			
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT MAX(country_id) FROM sakila_country";
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				countryIdMax = (rs.getInt("MAX(country_id)")) + 1;
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
		return countryIdMax;
	}
	
	//국가 추가
	public void insertCountry(Country country) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_country(country_id, country, last_update) VALUES (?, ?, NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, country.getCountryId());
			stmt.setString(2, country.getCountry());
			stmt.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
				stmt.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	//현재 페이지, 페이지에 몇개 리스트 출력할 지
	public int selectLastPage(int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalPage = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT count(*) FROM sakila_country";
			stmt = conn.prepareStatement(sql);
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
	
	
	public ArrayList<Country> selectStaffByPage(String searchWord, int beginRow, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Country> list=new ArrayList<Country>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();		
			String sql = "SELECT * FROM sakila_country WHERE country like ? LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Country country = new Country();
				country.setCountryId(rs.getInt("country_id"));
				country.setCountry(rs.getString("country"));
				country.setLastUpdate(rs.getString("last_update"));			
				list.add(country);		
				
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
	
	//현재 페이지, 페이지에 몇개 리스트 출력할 지
	public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalPage = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT count(*) FROM sakila_country WHERE country like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
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
}
