<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="vo.Language"%>
<%@page import="dao.LanguageDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>  
<meta charset="UTF-8">
</head>
<style>
    body {
        padding: 0;
        margin: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background-position: 0 0;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size: cover;
        position: relative;
        overflow-y: auto;
		background-color: white;
    }
    
    #aside {
        width: 200px;
        height: 3000px;
        position: fixed;
        background: white;
        overflow: hidden;
        float: left;
    }
    
    #section {
        margin-left: 200px;
        padding : 20px;
        background: white;
    }
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	ArrayList<String> languageName = new ArrayList<String>();
	LanguageDao languageDao = new LanguageDao();
	
	String a = "";
	ArrayList<Language> languageList = languageDao.selectLanguageList(a);
	
%>
	<div style="widows: 100%; padding: 0; margin: 0; height: 20px; background-color: #b8daff;">
	
	</div>
    <div id="aside">
         <jsp:include page="/inc/sidemenu.jsp"></jsp:include>
    </div>
    <div id="section">
        <h1 style="padding-top: 30px;">Film Insert Form</h1>
        <div class="row" style="margin:0">
		<div class="col-*-*"> 	
		
        <form method="post" style="margin-bottom: 20px" action="<%=request.getContextPath()%>/film/insertFilmAction.jsp">
        <fieldset>
    			<table class="table table-bordered table-hover">							
				<tbody>					
					<tr>
						<td>TITLE</td>						
						<td><input class="form-control-plaintext inputstl" placeholder="영화 제목" type="text" name="title"></td>
					</tr>
					<tr>
						<td>DESCRIPTION</td>						
						<td><input class="form-control-plaintext inputstl" placeholder="영화 설명" type="text" name="description"></td>
					</tr>
					<tr>
						<td>RELEASE YEAR</td>						
						<td>
							<select class="form-control inputstl" name="releaseYear">
								<%					
									Calendar calendar = new GregorianCalendar(Locale.KOREA);
									int Year = calendar.get(Calendar.YEAR);
									for(int i=1901; i<=2155; i=i+1){
										if(i == Year){
								%>
											<option value="<%=i%>" selected="selected"><%=i %> 년
								<%
										}else{
								%>
											<option value="<%=i%>"><%=i %> 년
								<%		
										}				
									}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>LANGUAGE</td>
						<td>
							<select class="form-control inputstl" name="language">
								<%
									for(Language l : languageList){
								%>
										<option value="<%=l.getLanguageId()%>"><%=l.getName() %>
								<%
									}
								%>
							</select>						
						</td>
					</tr>
					<tr>
						<td>RENTAL DURATION</td>						
						<td>
							<input class= "form-control-plaintext inputstl" placeholder="대여 기간" type="text" name="rentalDuration">
						</td>						
					</tr>				
					
					<tr>
						<td>RENTAL RATE</td>						
						<td><input class="form-control-plaintext inputstl" placeholder="대여료" type="text" name="rentalRate"></td>
					</tr>
					
					<tr>
						<td>LENGTH</td>						
						<td><input class="form-control-plaintext inputstl" placeholder="영화 시간" type="text" name="length"></td>
					</tr>
					
					<tr>
						<td>REPLACEMENT COST</td>						
						<td><input class="form-control-plaintext inputstl" placeholder="보상비용" type="text" name="replacementCost"></td>
					</tr>
					
					<tr>
						<td>RATING</td>						
						<td>
							<select class="form-control inputstl" name="rating">
								<option value="G">G</option>
								<option value="PG">PG</option>
								<option value="PG-13">PG-13</option>
								<option value="R">R</option>
								<option value="NC-17">NC-17</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>SPECIAL REATURES</td>						
						<td>
							<div class="custom-control custom-checkbox">
						    	<input type="checkbox" class="custom-control-input" id="customCheck" name="specialFeatures" value="1">
						      	<label class="custom-control-label" for="customCheck">Trailers</label>
						    </div>
						    
						    <div class="custom-control custom-checkbox">
						    	<input type="checkbox" class="custom-control-input" id="customCheck2" name="specialFeatures" value="2">
						      	<label class="custom-control-label" for="customCheck2">Commentaries</label>
						    </div>
						    
						    <div class="custom-control custom-checkbox">
						      <input type="checkbox" class="custom-control-input" id="customCheck3" name="specialFeatures" value="4">
						      <label class="custom-control-label" for="customCheck3">Deleted Scenes</label>
						    </div>
						    
						    <div class="custom-control custom-checkbox">
						    <input type="checkbox" class="custom-control-input" id="customCheck4" name="specialFeatures" value="8">
						      <label class="custom-control-label" for="customCheck4">Behind the Scenes</label>
						    </div>
    
    
    
						
						<!-- <div class="custom-control custom-checkbox">
						    <input type="checkbox" class="custom-control-input" name="specialFeatures" value="1">
						    <label class="custom-control-label" for="customCheck">Trailers</label>
						    
						    <input type="checkbox" class="custom-control-input" name="specialFeatures" value="2">
						    <label class="custom-control-label" for="customCheck">Commentaries</label>
						    
						    <input type="checkbox" class="custom-control-input" name="specialFeatures" value="4">
						    <label class="custom-control-label" for="customCheck">Deleted Scenes</label>
						    
						    <input type="checkbox" class="custom-control-input" name="specialFeatures" value="8">
						    <label class="custom-control-label" for="customCheck">Behind the Scenes</label>
						</div> -->
						
	
						
						
						
						<!-- <div class="checkbox icheck-primary">
							<input type="checkbox" name="specialFeatures" value="1">Trailers
							<input type="checkbox" name="specialFeatures" value="2">Commentaries
							<input type="checkbox" name="specialFeatures" value="4">Deleted Scenes
							<input type="checkbox" name="specialFeatures" value="8">Behind the Scenes
						</div> -->
						</td>
						
							
						</tr>
					
				</tbody>
			</table>
    			
    		</fieldset>
        	      	
        	<button class="btn btn-outline-primary" type="submit">영화 추가</button>
        </form>
        </div>
    	<div class="col-*-*"></div>
    	</div>
    </div>
</body>
</html>