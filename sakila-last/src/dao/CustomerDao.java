package dao;
import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class CustomerDao {
	//rantal join을 위해 받을 값
	public ArrayList<Customer> selectCustomerIdList() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Customer> list=new ArrayList<Customer>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT customer_id, first_name, last_name FROM sakila_customer";
			stmt = conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			while (rs.next()) {
				Customer c = new Customer();
				c.setCustomerId(rs.getInt("customer_id"));
				c.setFirstName(rs.getString("first_name"));
				c.setLastName(rs.getString("last_name"));
				
				list.add(c);
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
	public void insertCustomer(Customer customer) throws Exception {
	
	Connection conn = null;
	PreparedStatement stmt = null;
	try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "INSERT INTO sakila_customer(store_id, first_name, last_name, email, address_id, create_date, last_update) VALUES(?, ?, ?, ?, ?, ?, now())";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customer.getStoreId());
		stmt.setString(2, customer.getFirstName());
		stmt.setString(3, customer.getLastName());
		stmt.setString(4, customer.getEmail());
		stmt.setInt(5, customer.getAddressId());
		stmt.setString(6, customer.getCreateDate());
		
		stmt.executeQuery();
		
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
	

	
	//Customer list
	public ArrayList<Customer> selectCustomerList(String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Customer> list = new ArrayList<Customer>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT customer_id, store_id, CONCAT(first_name,' ',last_name) AS full_name, email, address_id, active, create_date, last_update FROM sakila_customer WHERE first_name like ? or last_name like ? ORDER BY customer_id asc";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%"); // first name 검색값
			stmt.setString(2, "%"+searchWord+"%"); // last name 검색값
			rs = stmt.executeQuery();
			while(rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getInt("customer_id"));
				customer.setStoreId(rs.getInt("store_id"));
				customer.setFullName(rs.getString("full_name")); // full name = first_name + last_name
				customer.setEmail(rs.getString("email"));
				customer.setAddressId(rs.getInt("address_id"));
				customer.setActive(rs.getInt("active"));
				customer.setCreateDate(rs.getString("create_date"));
				customer.setLastUpdate(rs.getString("last_update"));
				list.add(customer);	
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
	
	
		public ArrayList<Customer> selectCustomerAll(int searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Customer> list = new ArrayList<Customer>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT customer_id, store_id, CONCAT(first_name,' ',last_name) AS full_name, email, address_id, active, create_date, last_update FROM sakila_customer WHERE customer_id=? ORDER BY customer_id asc";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, searchWord);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getInt("customer_id"));
				customer.setStoreId(rs.getInt("store_id"));
				customer.setFullName(rs.getString("full_name")); // full name = first_name + last_name
				customer.setEmail(rs.getString("email"));
				customer.setAddressId(rs.getInt("address_id"));
				customer.setActive(rs.getInt("active"));
				customer.setCreateDate(rs.getString("create_date"));
				customer.setLastUpdate(rs.getString("last_update"));
				list.add(customer);	
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
				String sql = "SELECT count(*) FROM sakila_customer WHERE first_name like ? or last_name like ?";
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
		
		//Customer list
		public ArrayList<Customer> selectCustomerList(String searchWord, int beginRow, int rowPerPage) throws Exception{
			
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			ArrayList<Customer> list = new ArrayList<Customer>();
			try {
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				String sql = "SELECT customer_id, store_id, CONCAT(first_name,' ',last_name) AS full_name, email, address_id, active, create_date, last_update FROM sakila_customer WHERE first_name like ? or last_name like ? ORDER BY customer_id asc LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+searchWord+"%"); // first name 검색값
				stmt.setString(2, "%"+searchWord+"%"); // last name 검색값
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Customer customer = new Customer();
					customer.setCustomerId(rs.getInt("customer_id"));
					customer.setStoreId(rs.getInt("store_id"));
					customer.setFullName(rs.getString("full_name")); // full name = first_name + last_name
					customer.setEmail(rs.getString("email"));
					customer.setAddressId(rs.getInt("address_id"));
					customer.setActive(rs.getInt("active"));
					customer.setCreateDate(rs.getString("create_date"));
					customer.setLastUpdate(rs.getString("last_update"));
					list.add(customer);	
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
