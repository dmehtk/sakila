package dao;
import vo.*;
import java.util.*;
import util.DBUtil;
import java.sql.*;
public class FilmCategoryDao {
	//film category list
	public ArrayList<FilmCategoryAndFilmAndCategory> selectFilmCategoryAll(String searchWord, int beginRow, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<FilmCategoryAndFilmAndCategory> list = new ArrayList<FilmCategoryAndFilmAndCategory>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql="SELECT  ca.category_id, ca.name, fi.film_id, fi.title, fi.description" + 
					" FROM sakila_film fi INNER JOIN sakila_category ca INNER JOIN sakila_film_category fc" + 
					" ON fi.film_id = fc.film_id AND fc.category_id = ca.category_id WHERE fi.title like ? ORDER BY category_id LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				FilmCategoryAndFilmAndCategory fcfc = new FilmCategoryAndFilmAndCategory();
				
				FilmCategory filmCategory = new FilmCategory();
				filmCategory.setFilmId(rs.getInt("film_id"));
				filmCategory.setCategoryId(rs.getInt("category_id"));
				
				fcfc.setFilmCategory(filmCategory);
				
				Film film = new Film();
				film.setFilmId(rs.getInt("film_id"));
				film.setTitle(rs.getString("title"));
				film.setDescription(rs.getString("description"));
				
				fcfc.setFilm(film);
				
				Category category = new Category();
				category.setCategoryId(rs.getInt("category_id"));
				category.setName(rs.getString("name"));
				
				fcfc.setCategory(category);
				
				list.add(fcfc);
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
	// total count 값 구하기
		public int totalCount() throws Exception{
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT count(*) from sakila_film_category";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			int totalCount = 0;
			if(rs.next()) {
				totalCount = rs.getInt("count(*)");
			}
			return totalCount;
		}
		//last page 값 구하기
		public int selectLastPage(String searchWord, int rowPerPage) throws Exception{
		      
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				int totalPage = 0;
				try {
					DBUtil dbUtil = new DBUtil();
				      conn = dbUtil.getConnection();
				      String sql = "SELECT count(*) FROM sakila_film_category fc INNER JOIN sakila_film f ON f.film_id = fc.film_id WHERE f.title like ? ";
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
