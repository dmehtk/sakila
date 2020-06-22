package dao;

import vo.*;

import util.*;
import java.sql.*;
import java.util.*;


public class LanguageDao {
	public Language insertLanguage(Language language) throws Exception {
		
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_language(name, last_update) VALUES(?, now())";
			stmt = conn.prepareStatement(sql);		
			stmt.setString(1, language.getName());
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
		return language;
	}
	
	
	
	
	
	public ArrayList<Language> selectLanguageList(String searchWord) throws Exception {
		System.out.println("LanguageDao ----------");
		System.out.println(searchWord+"<----searchWord"); 
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Language> list = new ArrayList<Language>();
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			String sql = "SELECT language_id, name, last_update FROM sakila_language WHERE name like ? ORDER BY language_id ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			rs = stmt.executeQuery();
			while(rs.next()) {
				Language language = new Language();
				language.setLanguageId(rs.getInt("language_id"));
				language.setName(rs.getString("name"));
				language.setLastUpdate(rs.getString("last_update"));
				list.add(language);
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
