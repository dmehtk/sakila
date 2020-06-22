package dao;

import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;

public class CategoryDao {
	
	public ArrayList<Category> selectCategoryList(String searchWord) throws Exception{
		System.out.println("CategoryDao ---------------");
		System.out.println(searchWord+"<----searchWord"); // 검색값이 넘어오는지 확인
	
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Category> list = new ArrayList<Category>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement("SELECT category_id, name, last_update from sakila_category WHERE name LIKE ? order by category_id asc ");
			stmt.setString(1, "%"+searchWord+"%");
			rs = stmt.executeQuery();
			Category category = null;
			while(rs.next()) {
				category = new Category();
				category.setCategoryId(rs.getInt("category_id"));
				category.setName(rs.getString("name"));
				category.setLastUpdate(rs.getString("last_update"));
				list.add(category);
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
		System.out.println(list.size()+"<---list.size");
		return list;
	}
	public Category insertCategory(Category category) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_category(name, last_update) VALUES(?,now())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getName());
			stmt.executeQuery();
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
		return category;
	}
}
