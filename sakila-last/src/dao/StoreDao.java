package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class StoreDao {
	
	
	public ArrayList<Integer> selectStoreIdList() throws Exception{
		//SELECT store_id FROM store
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Integer> list=new ArrayList<Integer>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT store_id FROM sakila_store";
			stmt = conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt("store_id"));
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
	
	public ArrayList<StoreAndStaffAndAddress> selectStoreListAll(String searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<StoreAndStaffAndAddress> list=new ArrayList<StoreAndStaffAndAddress>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT st.* , sf.* , ad.* FROM sakila_store st INNER JOIN sakila_staff sf INNER JOIN sakila_address ad ON st.manager_staff_id=sf.staff_id And st.address_id=ad.address_id";
			stmt = conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			while (rs.next()) {
				StoreAndStaffAndAddress staffAndAddress=new StoreAndStaffAndAddress();
				
				Store store=new Store();
				store.setStoreId(rs.getInt("st.store_id"));
				store.setManagerStaffId(rs.getInt("st.manager_staff_id"));
				store.setAddressId(rs.getInt("st.address_id"));
				store.setLastUpdate(rs.getString("st.last_update"));
				staffAndAddress.setStore(store);
				
				Staff staff=new Staff();
				staff.setFirstName(rs.getString("sf.first_name"));
				staff.setLastName(rs.getString("sf.last_name"));
				staffAndAddress.setStaff(staff);
				
				Address address=new Address();
				address.setAddress(rs.getString("ad.address"));
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
	
	public ArrayList<StoreAndStaffAndAddress> selectStoreAll(int searchWord) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<StoreAndStaffAndAddress> list=new ArrayList<StoreAndStaffAndAddress>();
		try {
			DBUtil dbUtil=new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT st.* , sf.* , ad.* FROM sakila_store st INNER JOIN sakila_staff sf INNER JOIN sakila_address ad ON st.manager_staff_id=sf.staff_id And st.address_id=ad.address_id where st.store_id like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, searchWord);
			rs= stmt.executeQuery();
			while (rs.next()) {
				StoreAndStaffAndAddress staffAndAddress=new StoreAndStaffAndAddress();
				
				Store store=new Store();
				store.setStoreId(rs.getInt("st.store_id"));
				store.setManagerStaffId(rs.getInt("st.manager_staff_id"));
				store.setAddressId(rs.getInt("st.address_id"));
				store.setLastUpdate(rs.getString("st.last_update"));
				staffAndAddress.setStore(store);
				
				Staff staff=new Staff();
				staff.setFirstName(rs.getString("sf.first_name"));
				staff.setLastName(rs.getString("sf.last_name"));
				staffAndAddress.setStaff(staff);
				
				Address address=new Address();
				address.setAddress(rs.getString("ad.address"));
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
}	
