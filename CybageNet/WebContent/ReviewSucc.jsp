<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
Connection con;
PreparedStatement pst;
RequestDispatcher rd;
String rev=request.getParameter("review");
try
{
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");

String uname=(String)pageContext.getAttribute("uname",PageContext.SESSION_SCOPE);
//int book_id=(int) session.getAttribute("bid");
String s = (String) pageContext.getAttribute("bid",PageContext.SESSION_SCOPE);
int bid = Integer.parseInt(s);
String review=request.getParameter("review");
String bname = (String) pageContext.getAttribute("bname",PageContext.SESSION_SCOPE);
pst=con.prepareStatement("insert into review values (?,?,?,?) ");
pst.setInt(1, bid);
pst.setString(2, bname);
pst.setString(3, review);
pst.setString(4, uname);
pst.executeUpdate();
out.print("Your Review have been Recorded");
}
catch (ClassNotFoundException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
} catch (SQLException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
} %>
</body>
</html>