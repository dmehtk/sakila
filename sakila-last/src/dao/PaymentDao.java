package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;
public class PaymentDao {
	//payment List + searchWord + paging
	public ArrayList<PaymentAndCustomerAndStaff> selectPaymentAndCustomerAndStaffAll(String searchWord , int beginRow, int rowPerPage) throws Exception {
		System.out.println(searchWord+"<---searchWord");
		System.out.println(beginRow+"<--beginRow");
		System.out.println(rowPerPage+"<--rowPerPage");
		
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<PaymentAndCustomerAndStaff> list = new ArrayList<PaymentAndCustomerAndStaff>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT p.*, s.*, c.* FROM sakila_payment p INNER JOIN sakila_customer c INNER JOIN sakila_staff s ON p.staff_id = s.staff_id AND p.customer_id = c.customer_id WHERE p.payment_id like ? ORDER BY p.payment_id ASC limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				PaymentAndCustomerAndStaff pacas = new PaymentAndCustomerAndStaff();
				Payment payment = new Payment();
				payment.setPaymentId(rs.getInt("p.payment_id"));
				payment.setCustomerId(rs.getInt("p.customer_id"));
				payment.setStaffId(rs.getInt("p.staff_id"));
				payment.setRentalId(rs.getInt("p.rental_id"));
				payment.setAmount(rs.getFloat("p.amount"));
				payment.setPaymentDate(rs.getString("p.payment_date"));
				payment.setLastUpdate(rs.getString("p.last_update"));
				pacas.setPayment(payment);
				
				Customer customer = new Customer();
				customer.setCustomerId(rs.getInt("c.customer_id"));
				customer.setFirstName(rs.getString("c.first_name"));
				customer.setLastName(rs.getString("c.last_name"));
				pacas.setCustomer(customer);
				
				Staff staff = new Staff();
				staff.setStaffId(rs.getInt("s.staff_id"));
				staff.setUsername(rs.getString("s.username"));
				pacas.setStaff(staff);
				
				list.add(pacas);
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
	// totalPage
	public int totalCount() throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT count(*) from sakila_payment";
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
	 // lastPage + searchWord
	public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
	     
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			int totalPage = 0;
			try {
				 DBUtil dbUtil = new DBUtil();
			      conn = dbUtil.getConnection();
			      String sql = "SELECT count(*) FROM sakila_payment WHERE payment_id like ?";
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
	// insert payment
	public void insertPayment(Payment payment) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_payment(customer_id, staff_id, rental_id, amount, payment_date, last_update) VALUES(?,?,?,?,now(),now())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, payment.getCustomerId());
			stmt.setInt(2, payment.getStaffId());
			stmt.setInt(3, payment.getRentalId());
			stmt.setFloat(4, payment.getAmount());
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
	
	public ArrayList<PaymentAndCustomerAndStaff> selectPaymentAndCustomerAndStaffAll(String searchWord) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<PaymentAndCustomerAndStaff> list = new ArrayList<PaymentAndCustomerAndStaff>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT p.*, s.*, c.* FROM sakila_payment p INNER JOIN sakila_customer c INNER JOIN sakila_staff s ON p.staff_id = s.staff_id AND p.customer_id = c.customer_id where p.customer_id like ? ORDER BY p.payment_id ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				PaymentAndCustomerAndStaff pacas = new PaymentAndCustomerAndStaff();
				Payment payment = new Payment();
				payment.setPaymentId(rs.getInt("p.payment_id"));
				payment.setCustomerId(rs.getInt("p.customer_id"));
				payment.setStaffId(rs.getInt("p.staff_id"));
				payment.setRentalId(rs.getInt("p.rental_id"));
				payment.setAmount(rs.getFloat("p.amount"));
				payment.setPaymentDate(rs.getString("p.payment_date"));
				payment.setLastUpdate(rs.getString("p.last_update"));
				pacas.setPayment(payment);
				
				Customer customer = new Customer();
				customer.setCustomerId(rs.getInt("c.customer_id"));
				customer.setFirstName(rs.getString("c.first_name"));
				customer.setLastName(rs.getString("c.last_name"));
				pacas.setCustomer(customer);
				
				Staff staff = new Staff();
				staff.setStaffId(rs.getInt("s.staff_id"));
				staff.setUsername(rs.getString("s.username"));
				pacas.setStaff(staff);
				
				list.add(pacas);
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
	/*
	public ArrayList<PaymentAndCustomerAndStaff> selectPaymentAndCustomerAndStaffList(int searchWord) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT p.*, s.*, c.* FROM payment p INNER JOIN customer c INNER JOIN staff s ON p.staff_id = s.staff_id AND p.customer_id = c.customer_id where p.customer_id like ? ORDER BY p.payment_id ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchWord);
		stmt.setInt(2, searchWord);
		ResultSet rs = stmt.executeQuery();
		ArrayList<PaymentAndCustomerAndStaff> list = new ArrayList<PaymentAndCustomerAndStaff>();
		while(rs.next()) {
			PaymentAndCustomerAndStaff pacas = new PaymentAndCustomerAndStaff();
			Payment payment = new Payment();
			payment.setPaymentId(rs.getInt("p.payment_id"));
			payment.setCustomerId(rs.getInt("p.customer_id"));
			payment.setStaffId(rs.getInt("p.staff_id"));
			payment.setRentalId(rs.getInt("p.rental_id"));
			payment.setAmount(rs.getFloat("p.amount"));
			payment.setPaymentDate(rs.getString("p.payment_date"));
			payment.setLastUpdate(rs.getString("p.last_update"));
			pacas.setPayment(payment);
			
			Customer customer = new Customer();
			customer.setCustomerId(rs.getInt("c.customer_id"));
			customer.setFirstName(rs.getString("c.first_name"));
			customer.setLastName(rs.getString("c.last_name"));
			pacas.setCustomer(customer);
			
			Staff staff = new Staff();
			staff.setStaffId(rs.getInt("s.staff_id"));
			staff.setUsername(rs.getString("s.username"));
			pacas.setStaff(staff);
			
			list.add(pacas);
		}
		return list;
		
	}
	*/
}
