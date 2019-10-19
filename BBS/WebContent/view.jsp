<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Jsp 웹 게시판</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('this page can not see')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP web site</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">main</a></li>
				<li class="active"><a href="bbs.jsp">board</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdownd">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">contact<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">login</a></li>
						<li><a href="join.jsp">membership</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdownd">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">memberCheck<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">logout</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeedee; text-align: center;">page check</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">title</td>
					<!--
					-->
					<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
					<tr>
						<td>writer</td>
						<td colspan="2"><%= bbs.getBbsID() %></td>
					</tr>
					<tr>
						<td>wrote time</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11) +
								bbs.getBbsDate().substring(11, 13) + "시 " +
								bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td style="width: 20%;">title</td>
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>content</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>

				</tbody>
			</table>
			<a href= "bbs.jsp" class="btn btn-primary">list</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
				<a href = "update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">change</a>
				<a href = "deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">delete</a>
			<%
				}
			%>
				<input type="submit" class="btn btn-primary pull-right" value="write">
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>