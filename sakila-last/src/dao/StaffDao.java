package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Address;
import vo.Staff;
import vo.StaffAndAddress;

public class StaffDao {
	
	//rantal join을 위해 받아올 값
	public ArrayList<Integer> selectStaffId() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Integer> list=new ArrayList<Integer>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT staff_id FROM sakila_staff";
			stmt = conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getInt("staff_id"));
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
	
	
	public ArrayList<StaffAndAddress> selectStaffListAll(String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<StaffAndAddress> list=new ArrayList<StaffAndAddress>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT sf.* , ad.address FROM sakila_staff sf INNER JOIN sakila_address ad ON sf.address_id=ad.address_id WHERE first_name LIKE ? or last_name LIKE ? order by staff_id ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setString(2, "%"+searchWord+"%");
			rs= stmt.executeQuery();

			while(rs.next()) {
				StaffAndAddress staffAndAddress=new StaffAndAddress();
				Staff staff=new Staff();
				staff.setStaffId(rs.getInt("staff_id"));
				staff.setFirstName(rs.getString("first_name"));
				staff.setLastName(rs.getString("last_name"));
				staff.setEmail(rs.getString("email"));
				staff.setStoreId(rs.getInt("store_id"));
				staff.setActive(rs.getInt("active"));
				staff.setUsername(rs.getString("username"));
				staff.setPassword(rs.getString("password"));
				staffAndAddress.setStaff(staff);
				
				Address address=new Address();
				address.setAddress(rs.getString("address"));
				staffAndAddress.setAddress(address);
				
				list.add(staffAndAddress);	
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
	
	public void insertStaff(Staff staff) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_staff(first_name, last_name, address_id, email, store_id, username, password, last_update) VALUES(?, ?, ?, ?, ?, ?, ?, now())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, staff.getFirstName());
			stmt.setString(2, staff.getLastName());
			stmt.setInt(3, staff.getAddressId());
			stmt.setString(4, staff.getEmail());
			stmt.setInt(5, staff.getStoreId());		
			stmt.setString(6, staff.getUsername());
			stmt.setString(7, staff.getPassword());		
			
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
}
