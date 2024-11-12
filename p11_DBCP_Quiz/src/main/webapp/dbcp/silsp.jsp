<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="/style/style.css?v">
</head>
<body>
	<div id="wrap">
		<h1>상품목록</h1>
		
		<main id="main">
			<div id="headerRow" class="colWid dFlex">
				<span>번호</span>
				<span>상품코드</span>
				<span>상품명</span>
				<span>가격</span>
				<span>재고</span>
			</div>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
try {
	Context init = new InitialContext(); 
	DataSource dataSource = (DataSource)init.lookup("java:comp/env/jdbc/dbcpConn");
	conn = dataSource.getConnection();
	
	stmt = conn.createStatement();
	String sql = "select num, goodsCode, goodsName, price, cnt ";
	sql += "from goodsList order by num desc";
	rs = stmt.executeQuery(sql);
	
	while(rs.next()) {
%>
			<div class="dataRow colWid dFlex">
				<span><%=rs.getInt(1) %></span>
				<span><%=rs.getString(2) %></span>
				<span><%=rs.getString(3) %></span>
				<span><%=rs.getInt(4) %></span>
				<span><%=rs.getInt(5) %></span>
			</div>
<%	
	}
} catch(Exception e) {
	out.print(e.getMessage());
} finally {

	try { if(rs != null) rs.close(); } catch(SQLException e) {}
	try { if(stmt != null) stmt.close(); } catch(SQLException e) {}
	try { if(conn != null) conn.close(); } catch(SQLException e) {}
	
}

%>			
		</main>
		
	</div>
	<!-- div#wrap -->
	<script src="/script/jquery-3.7.1.min.js"></script>
	<script src="/script/script.js"></script>
</body>
</html>    