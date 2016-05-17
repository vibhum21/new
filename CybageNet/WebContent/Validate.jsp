<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<%
Connection con;
Statement st;
ResultSet rs;
RequestDispatcher rd;
String name=request.getParameter("uname");
String pass=request.getParameter("pass");
System.out.println(name);
pageContext.setAttribute("uname",name,PageContext.SESSION_SCOPE);

try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	System.out.println("connection");
	st=con.createStatement();
	rs=st.executeQuery("select * from login where username='"+name+"'and password='"+pass+"'");
	System.out.println("connection");
	
	while(rs.next())
	{
			pageContext.setAttribute("uname",PageContext.SESSION_SCOPE); 
	
			String type=rs.getString(3);
			if(type.equals("admin"))
			{
				rd=request.getRequestDispatcher("AdminHome.jsp");
				rd.forward(request, response);
			}
			else if(type.equals("user"))
			{
				rd=request.getRequestDispatcher("UserHome.jsp");
				rd.forward(request, response);
			}
			else
			{
				rd=request.getRequestDispatcher("Relogin.jsp");
				rd.forward(request, response);
			}
	}
}
catch (SQLException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
}
catch (ClassNotFoundException e) {
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
}
%>

 </body>
</html>