package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;

public class RentalDao {
	
	public void insertRental(Rental rental) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_rental(rental_date, inventory_id, customer_id, return_date, staff_id, last_update) VALUES(?, ?, ?, now(), ?, now())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, rental.getRentalDate());
			stmt.setInt(2, rental.getInventoryId());
			stmt.setInt(3, rental.getCustomerId());
			stmt.setInt(4, rental.getStaffId());
			
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
	public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalPage = 0;
		int staffCount = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT Count(*) FROM sakila_rental WHERE rental_id LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			rs = stmt.executeQuery();

			if(rs.next()) {
				staffCount = rs.getInt("Count(*)");
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
		System.out.println("staffCount : " + staffCount);		
		System.out.println("토탈페이지 : " + totalPage);
		return totalPage;
	}
	
	//현재 페이지, 페이지에 몇개 리스트 출력할 지
		public int selectLastPage(int searchWord, int rowPerPage) throws Exception{
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			int totalPage = 0;
			int staffCount = 0;
			try {
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				String sql = "SELECT Count(*) FROM sakila_rental WHERE rental_id = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, searchWord);
				rs = stmt.executeQuery();
				if(rs.next()) {
					staffCount = rs.getInt("Count(*)");
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
			System.out.println("staffCount : " + staffCount);		
			System.out.println("토탈페이지 : " + totalPage);
			
			return totalPage;
		}
	
	
	
	//전체 행수
	public int selectTotlaCount(int searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalRow=0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT Count(*) from sakila_rental where rental_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, searchWord);
			rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow=rs.getInt("Count(*)");
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
		return totalRow;
		
	}
	
	public int selectTotlaCount(String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalRow=0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT Count(*) from sakila_rental where rental_id like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				totalRow=rs.getInt("Count(*)");
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
		return totalRow;
		
	}
	
	//페이징 함수
	public ArrayList<RentalAndStaff> selectRentalAndStaff(int beginPage,int rowPerPage,String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<RentalAndStaff> list = new ArrayList<RentalAndStaff>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT r.*, s.* FROM sakila_rental r INNER JOIN sakila_staff s ON r.staff_id = s.staff_id where r.rental_id LIKE ? order By rental_id asc limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginPage);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				RentalAndStaff rentalAndStaff = new RentalAndStaff();
				Rental rental = new Rental();
				rental.setRentalId(rs.getInt("r.rental_id"));
				rental.setRentalDate(rs.getString("r.rental_date"));
				rental.setInventoryId(rs.getInt("r.inventory_id"));
				rental.setCustomerId(rs.getInt("r.customer_id"));
				rental.setReturnDate(rs.getString("r.return_date"));
				rental.setStaffId(rs.getInt("r.staff_id"));
				rental.setLastUpdate(rs.getString("r.last_update"));
				rentalAndStaff.setRental(rental);
				
				Staff staff = new Staff();
				staff.setStaffId(rs.getInt("s.staff_id"));
				staff.setUsername(rs.getString("s.username"));
				rentalAndStaff.setStaff(staff);
				
				list.add(rentalAndStaff);
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
	
	//페이징 함수
		public ArrayList<RentalAndStaff> selectRentalAndStaffsearch(int beginPage,int rowPerPage,int searchWord) throws Exception{
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			ArrayList<RentalAndStaff> list = new ArrayList<RentalAndStaff>();
			try {
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				String sql="SELECT r.*, s.* FROM sakila_rental r INNER JOIN sakila_staff s ON r.staff_id = s.staff_id where r.rental_id = ? order By rental_id asc limit ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, searchWord);
				stmt.setInt(2, beginPage);
				stmt.setInt(3, rowPerPage);
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					RentalAndStaff rentalAndStaff = new RentalAndStaff();
					Rental rental = new Rental();
					rental.setRentalId(rs.getInt("r.rental_id"));
					rental.setRentalDate(rs.getString("r.rental_date"));
					rental.setInventoryId(rs.getInt("r.inventory_id"));
					rental.setCustomerId(rs.getInt("r.customer_id"));
					rental.setReturnDate(rs.getString("r.return_date"));
					rental.setStaffId(rs.getInt("r.staff_id"));
					rental.setLastUpdate(rs.getString("r.last_update"));
					rentalAndStaff.setRental(rental);
					
					Staff staff = new Staff();
					staff.setStaffId(rs.getInt("s.staff_id"));
					staff.setUsername(rs.getString("s.username"));
					rentalAndStaff.setStaff(staff);
					
					list.add(rentalAndStaff);
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
	
	public ArrayList<RentalAndStaff> selectRentalAndStaff(String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<RentalAndStaff> list = new ArrayList<RentalAndStaff>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT r.*, s.* FROM sakila_rental r INNER JOIN sakila_staff s ON r.staff_id = s.staff_id where r.rental_id like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			rs = stmt.executeQuery();
			while(rs.next()) {
				RentalAndStaff rentalAndStaff = new RentalAndStaff();
				Rental rental = new Rental();
				rental.setRentalId(rs.getInt("r.rental_id"));
				rental.setRentalDate(rs.getString("r.rental_date"));
				rental.setInventoryId(rs.getInt("r.inventory_id"));
				rental.setCustomerId(rs.getInt("r.customer_id"));
				rental.setReturnDate(rs.getString("r.return_date"));
				rental.setStaffId(rs.getInt("r.staff_id"));
				rental.setLastUpdate(rs.getString("r.last_update"));
				rentalAndStaff.setRental(rental);
				
				Staff staff = new Staff();
				staff.setStaffId(rs.getInt("s.staff_id"));
				staff.setUsername(rs.getString("s.username"));
				rentalAndStaff.setStaff(staff);
				
				list.add(rentalAndStaff);
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
	
	public ArrayList<RentalAndStaff> selectRentalAndStaffAll(int searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<RentalAndStaff> list = new ArrayList<RentalAndStaff>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT r.*, s.* FROM sakila_rental r INNER JOIN sakila_staff s ON r.staff_id = s.staff_id where r.rental_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, searchWord);
			rs = stmt.executeQuery();
			while(rs.next()) {
				RentalAndStaff rentalAndStaff = new RentalAndStaff();
				Rental rental = new Rental();
				rental.setRentalId(rs.getInt("r.rental_id"));
				rental.setRentalDate(rs.getString("r.rental_date"));
				rental.setInventoryId(rs.getInt("r.inventory_id"));
				rental.setCustomerId(rs.getInt("r.customer_id"));
				rental.setReturnDate(rs.getString("r.return_date"));
				rental.setStaffId(rs.getInt("r.staff_id"));
				rental.setLastUpdate(rs.getString("r.last_update"));
				rentalAndStaff.setRental(rental);
				
				Staff staff = new Staff();
				staff.setStaffId(rs.getInt("s.staff_id"));
				staff.setUsername(rs.getString("s.username"));
				rentalAndStaff.setStaff(staff);
				
				list.add(rentalAndStaff);
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
