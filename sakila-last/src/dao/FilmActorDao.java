package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Actor;
import vo.Film;
import vo.FilmActor;
import vo.FilmActorAndFilmAndActor;

public class FilmActorDao {
	//filmActor list + search+ paging
	public ArrayList<FilmActorAndFilmAndActor> selectFilmActorListAll(String searchWord, int beginRow, int rowPerPage) throws Exception{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<FilmActorAndFilmAndActor> list = new ArrayList<FilmActorAndFilmAndActor>();
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT f.film_id, f.title, f.description, f.release_year, f.language_id, f.original_language_id, f.rental_duration, f.rental_rate, "
					+ "f.length, f.replacement_cost, f.rating, f.special_features, f.last_update, "
					+ "a.actor_id, a.first_name, a.last_name, a.last_update, "
					+ "fa.actor_id, fa.film_id, fa.last_update "
					+ "FROM sakila_film_actor fa INNER JOIN sakila_film f ON fa.film_id=f.film_id INNER JOIN sakila_actor a ON fa.actor_id=a.actor_id WHERE f.title LIKE ? ORDER BY f.title LIMIT ?, ?;";
			stmt = conn.prepareStatement(sql);		
			
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				FilmActorAndFilmAndActor fa = new FilmActorAndFilmAndActor();
				
				Film film = new Film();
				film.setFilmId(rs.getInt("f.film_id"));
				film.setTitle(rs.getString("f.title"));
				film.setDescription(rs.getString("f.description"));
				film.setReleaseYear(rs.getString("f.release_year"));
				film.setLanguageId(rs.getInt("f.language_id"));
				film.setOrininalLanguageId(rs.getInt("f.original_language_id"));
				film.setRentalDuration(rs.getInt("f.rental_duration"));
				film.setRentalRate(rs.getDouble("f.rental_rate"));
				film.setLength(rs.getInt("f.length"));
				film.setReplacementCost(rs.getDouble("f.replacement_cost"));
				film.setRating(rs.getString("f.rating"));
				film.setSpecialFeatures(rs.getString("f.special_features"));
				film.setLastUpdate(rs.getString("f.last_update"));
				
				Actor actor = new Actor();
				actor.setActorId(rs.getInt("a.actor_id"));
				actor.setFirstName(rs.getString("a.first_name"));
				actor.setLastName(rs.getString("a.last_name"));
				actor.setLastUpdate(rs.getString("a.last_update"));
				
				FilmActor filmActor = new FilmActor();
				filmActor.setActorId(rs.getInt("fa.actor_id"));
				filmActor.setFilmId(rs.getInt("fa.film_id"));
				filmActor.setLastUpdate(rs.getString("fa.last_update"));
				
				fa.setFilm(film);
				fa.setActor(actor);
				fa.setFilmActor(filmActor);
				
				list.add(fa);
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
			String sql = "SELECT count(*)FROM sakila_film_actor fa INNER JOIN sakila_film f ON fa.film_id=f.film_id INNER JOIN sakila_actor a ON fa.actor_id=a.actor_id WHERE f.title LIKE ?";
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
