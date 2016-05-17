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
int id=Integer.parseInt(request.getParameter("bid"));
Connection con;
PreparedStatement pst;
ResultSet rs;
RequestDispatcher rd;

try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	pst=con.prepareStatement("delete from books where bookid='"+id+"'");
	
	pst.executeUpdate();
	//response.sendRedirect("AdminHome.jsp");
	rd=request.getRequestDispatcher("AdminHome.jsp");
	rd.include(request, response);
	out.println("Record Deleted...");
}
catch (ClassNotFoundException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
} catch (SQLException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
}

%>
</body>
</html>