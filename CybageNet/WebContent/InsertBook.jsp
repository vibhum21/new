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
ResultSet rs;
RequestDispatcher rd;

int id=Integer.parseInt(request.getParameter("bid"));
String title=request.getParameter("bname");
int bookpage=Integer.parseInt(request.getParameter("bpage"));
String author=request.getParameter("bauthor");
int edition=Integer.parseInt(request.getParameter("bedition"));


try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	pst=con.prepareStatement("insert into books values(?,?,?,?,?)");
	pst.setInt(1, id);
	pst.setString(2, title);
	pst.setInt(3, bookpage);
	pst.setString(4, author);
	pst.setInt(5, edition);
	System.out.println("Book inserted successfully....");
	pst.executeUpdate();
	//response.sendRedirect("AdminHome.jsp");
	rd=request.getRequestDispatcher("AdminHome.jsp");
	rd.include(request, response);
	out.println("Record Inserted...");
	
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