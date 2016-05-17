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
Statement pst;
ResultSet rs;
RequestDispatcher rd;
String bname=request.getParameter("bname");
try {	
	String name=(String)pageContext.getAttribute("uname",PageContext.SESSION_SCOPE);
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/cybagenet","root","root");
	
	PreparedStatement ps=con.prepareStatement("select * from books where bookname=?");
	ps.setString(1, bname);
	rs=ps.executeQuery();
	int i=1;
	int  bookid=0;
	while(rs.next())
	{
		bookid=rs.getInt(1);
		out.println("<table><tr><td>Book Name:</td><td>"+rs.getString(2)+"</td></tr>");
		out.println("<tr><td>Author's Name:</td><td> "+rs.getString(3)+"</td></tr>");
		out.println("<tr><td>Publication:</td><td> "+rs.getString(4)+"</td></tr></table>");
	}
	                        
	PreparedStatement ps1=con.prepareStatement
			("select review,name from books,review where books.bookname=review.bookname and books.bookname=?");
	ps1.setString(1, bname);
	rs=ps1.executeQuery();
	while(rs.next())
	{
		
	out.println(" "+rs.getString(2)+"  says :\n "+rs.getString(1)+"<br><br>");
	i++;
	}
	out.println("<form action='ReviewSucc.jsp' method='post'>");
	out.println("Enter a Review"+"<br>"+"<input type='text' maxlength='500' name='review'>");
	out.println("<input type='submit' value='add review'>");
	
	String s=Integer.toString(bookid);
	
	pageContext.setAttribute("bname",name,PageContext.SESSION_SCOPE);
	pageContext.setAttribute("bid",s,PageContext.SESSION_SCOPE);
	
	out.println("</form>");
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