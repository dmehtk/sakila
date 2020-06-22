package dao;

import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class ActorDao {
	
	//Actor list
	public ArrayList<Actor> selectActorList(String searchWord, int beginRow, int rowPerPage) throws Exception{
		System.out.println(searchWord+"<---searchWord");
		System.out.println(beginRow+"<--beginRow");
		System.out.println(rowPerPage+"<--rowPerPage");
		System.out.println("AcotrDao ---------------");
		System.out.println(searchWord+"<----searchWord"); // 검색값이 넘어오는지 확인
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Actor> list = new ArrayList<Actor>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT actor_id, first_name, last_name, last_update FROM sakila_actor WHERE first_name like ? or last_name like ? ORDER BY actor_id ASC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setString(2, "%"+searchWord+"%");
			stmt.setInt(3, beginRow);
			stmt.setInt(4, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Actor actor = new Actor();
				actor.setActorId(rs.getInt("actor_id"));
				actor.setFirstName(rs.getString("first_name"));
				actor.setLastName(rs.getString("last_name"));
				actor.setLastUpdate(rs.getString("last_update"));
				list.add(actor);
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
	//insert Actor
	public void insertActor(Actor actor) throws Exception {
		System.out.println("dao로 넘어옴!");
		System.out.println(actor.getFirstName()+"<----firstname");
		System.out.println(actor.getLastName()+"<---lastname");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO sakila_actor(first_name, last_name, last_update) VALUES (?,?, NOW())";
			stmt = conn.prepareStatement(sql);		
			stmt.setString(1, actor.getFirstName());
			stmt.setString(2, actor.getLastName());
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
	
	// total count 값 구하기 , 검색값이 없을때
	public int totalCount() throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT count(*) from sakila_actor";
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
	//last page 값 구하기 , 검색값이 있을때
	public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
	      Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			int totalPage = 0;
			try {
				DBUtil dbUtil = new DBUtil();
			    conn = dbUtil.getConnection();
			    String sql = "SELECT count(*) FROM sakila_actor WHERE first_name like ? or last_name like ? ";
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
}
