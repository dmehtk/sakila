package dao;
import vo.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.*;

public class InventoryDao {
	
	// rantal
	public ArrayList<Integer> selectInventoryIdList() throws Exception{
	     
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			ArrayList<Integer> list=new ArrayList<Integer>();
			try {
				 DBUtil dbUtil=new DBUtil();
			      conn = dbUtil.getConnection();
			      String sql = "SELECT inventory_id FROM sakila_inventory";
			      stmt = conn.prepareStatement(sql);
			      rs= stmt.executeQuery();
			      
			      while (rs.next()) {
			         list.add(rs.getInt("inventory_id"));
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
	//페이징 
	public ArrayList<InventoryAndFilm> selectInventoryAndFilmListPaging(int beginPage,int rowPerPage,String searchWord) throws Exception {
		System.out.println("<--Inventory");
		System.out.println(searchWord+"<----searchWord");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<InventoryAndFilm> list = new ArrayList<InventoryAndFilm>();
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			String sql="SELECT i.*, f.film_id, f.title FROM sakila_inventory i INNER JOIN sakila_film f ON i.film_id = f.film_id WHERE i.film_id like ? or i.store_id like ? ORDER BY i.inventory_id ASC limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%"+searchWord+"%");
			stmt.setInt(3, beginPage);
			stmt.setInt(4, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs);
				InventoryAndFilm iaf = new InventoryAndFilm();
				Inventory inventory = new Inventory();
				inventory.setInventoryId(rs.getInt("i.inventory_id"));
				inventory.setFilmId(rs.getInt("i.film_id"));
				inventory.setStoreId(rs.getInt("i.store_id"));
				inventory.setLastUpdate(rs.getString("i.last_update"));
				iaf.setInventory(inventory);
				
				Film film = new Film();
				film.setFilmId(rs.getInt("f.film_id"));
				film.setTitle(rs.getString("f.title"));
				iaf.setFilm(film);
				
				list.add(iaf);
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
			String sql = "SELECT count(*) FROM sakila_inventory i INNER JOIN sakila_film f ON i.film_id = f.film_id WHERE i.film_id like ? or i.store_id like ?";
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
	
	//총 행수
	public int selectTotalCount() throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql="select count(*) cnt from sakila_inventory";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRow=0;
		if(rs.next()) {
			totalRow=rs.getInt("cnt");
		}
		return totalRow;
	}
	//삽입 모델
	public void insertInventory(Inventory inventory) throws Exception { 
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			String sql="INSERT INTO sakila_inventory(film_id, store_id, last_update) VALUES(?, ?, now())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, inventory.getFilmId());
			stmt.setInt(2, inventory.getStoreId());
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
	
	
	public ArrayList<InventoryAndFilm> selectInventoryAndFilmList(String searchWord) throws Exception {
		System.out.println("<--Inventory");
		System.out.println(searchWord+"<----searchWord");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<InventoryAndFilm> list = new ArrayList<InventoryAndFilm>();
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			String sql="SELECT i.*, f.film_id, f.title FROM sakila_inventory i INNER JOIN sakila_film f ON i.film_id = f.film_id WHERE i.film_id like ? or i.store_id like ? ORDER BY i.inventory_id ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%"+searchWord+"%");
			rs = stmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs);
				InventoryAndFilm iaf = new InventoryAndFilm();
				Inventory inventory = new Inventory();
				inventory.setInventoryId(rs.getInt("i.inventory_id"));
				inventory.setFilmId(rs.getInt("i.film_id"));
				inventory.setStoreId(rs.getInt("i.store_id"));
				inventory.setLastUpdate(rs.getString("i.last_update"));
				iaf.setInventory(inventory);
				
				Film film = new Film();
				film.setFilmId(rs.getInt("f.film_id"));
				film.setTitle(rs.getString("f.title"));
				iaf.setFilm(film);
				
				list.add(iaf);
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
	
	public ArrayList<InventoryAndFilm> selectInventoryAndFilmAll(int searchWord) throws Exception {
		System.out.println("<--Inventory");
		System.out.println(searchWord+"<----searchWord");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<InventoryAndFilm> list = new ArrayList<InventoryAndFilm>();
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			String sql="SELECT i.*, f.film_id, f.title FROM sakila_inventory i INNER JOIN sakila_film f ON i.film_id = f.film_id WHERE i.inventory_id = ? ORDER BY i.inventory_id ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, searchWord);
			rs = stmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs);
				InventoryAndFilm iaf = new InventoryAndFilm();
				Inventory inventory = new Inventory();
				inventory.setInventoryId(rs.getInt("i.inventory_id"));
				inventory.setFilmId(rs.getInt("i.film_id"));
				inventory.setStoreId(rs.getInt("i.store_id"));
				inventory.setLastUpdate(rs.getString("i.last_update"));
				iaf.setInventory(inventory);
				
				Film film = new Film();
				film.setFilmId(rs.getInt("f.film_id"));
				film.setTitle(rs.getString("f.title"));
				iaf.setFilm(film);
				
				list.add(iaf);
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
}
