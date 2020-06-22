<%@page import="dao.FilmDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	Film film = new Film();
	film.setTitle(request.getParameter("title"));
	film.setDescription(request.getParameter("description"));
	film.setReleaseYear(request.getParameter("releaseYear"));
	
	//select 해와야 함
	film.setLanguageId(Integer.parseInt(request.getParameter("language")));
	
	film.setRentalDuration(Integer.parseInt(request.getParameter("rentalDuration")));
	film.setRentalRate(Double.parseDouble(request.getParameter("rentalRate")));
	film.setLength(Integer.parseInt(request.getParameter("length")));
	film.setReplacementCost(Double.parseDouble(request.getParameter("replacementCost")));
	film.setRating(request.getParameter("rating"));
	
	int specialFeatures = 0;
	if(request.getParameter("specialFeatures") != null){
		String checkboxes[] = request.getParameterValues("specialFeatures");
		for(String r : checkboxes){
			specialFeatures += Integer.parseInt(r);
		}
	}
	film.setSpecialFeatures(Integer.toString(specialFeatures));
	
	FilmDao filmDao = new FilmDao();
	filmDao.insertFilm(film);
	
	response.sendRedirect(request.getContextPath()+"/film/filmList.jsp");
%>