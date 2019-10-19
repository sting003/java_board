<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('login plz')");
			script.println("location.href='login.jsp'");
			script.println("</script>");

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
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('you can not change this')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");

		}

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
		</div>
	</nav>
	<div class="container">
		<div class="row">
		<form method="post" action="updateAction.jsp?bbsID=<%=bbsID %>>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeedee; text-align: center;">write change form</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-cotrol" placeholder="title" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>" style="width: 500px;"></td>
					</tr>
					<tr>
						<td><textarea class="form-cotrol" placeholder="content" name="bbsContent" maxlength="2048" style="height: 220px; width: 500px;"><%=bbs.getBbsContent() %></textarea></td>
					</tr>
				</tbody>
			</table>

				<input type="submit" class="btn btn-primary pull-right" value="write">
		</form>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>