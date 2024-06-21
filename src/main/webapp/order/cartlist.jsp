<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Map"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="csmgr" class="pack.orders.CarSessionMgr" scope="session"/>
<jsp:useBean id="pdto" class="pack.product.ProductDto" />
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<jsp:useBean id="pmgr" class="pack.product.ProductMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<sctipt type="text/javascript" src="../js/script.js"></sctipt>
</head>
<body>
<h2>장바구니 화면 총합까지 구함</h2>
<!-- @ include file="guest_top.jsp" -->
	<hr>
	<table border="1">
		<tr style="background-color: pink" width="90%">
			<th>제품번호</th>
			<th>이미지</th>
			<th>제품이름</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
<% //userid = idKey
int totalPrice = 0; // 총합

Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 

if(hCart.size() == 0){
%>
<tr>
	<td>주문 건수가 없어요.</td>
</tr>
<%	
}else{
	for(Map.Entry<String, Order_productDto> entry : hCart.entrySet()){
		Order_productDto opddto = entry.getValue();
		
		ProductDto product = pmgr.getProduct(opdto.getName());
		int price= product.getPrice();
		int quantity = opddto.getQuantity();
		int subTotal = price * quantity; // 소계
		totalPrice += subTotal; // 총계

%>
<form action="cartproc.jsp" method="post">
	<input type="hidden" name="flag">
	<input type="hidden" name="product_name" value="<%=opdto.getQuantity() %>"
	style="text-align: center;">
	
	<tr>
		<td><%=opdto.getName() %></td>
		<td><%=subTotal %></td>
		<td>
			<input type="text" name="quantity" size="5" value="<%=quantity %>">
		</td>
		<td>
			<input style="background-color : aqua;" type="button" value="수정" onclick="cartUpdate(this.form)">
			<input style="background-color : aqua;" type="button" value="삭제" onclick="cartDelete(this.form)">
		</td>
	</tr>
</form>
<%
}
%>
<tr>
	<td colspan="5">
		<br>
			<b>총 결제 금액 : <%=totalPrice %>원</b>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="orderinfo.jsp">[주문하기]</a>
		</td>
	</tr>
<%
}
%>

</table>
<br>
<!-- 전체삭제 만들기 -->
<a href="javascript:cartproc()">[주문하기]</a>
<form action="cartproc.jsp" name="form" method="post">
	<input type="hidden" name="name">
	<input type="hidden" name="quantity">
</form>
</body>
</html>