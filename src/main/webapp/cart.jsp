<%@ page import="com.shopApp.product.Product"%>
<%@ page import="com.shopApp.product.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
<link rel="stylesheet" href="stylec.css">
<style type="text/css">
.bttnStyle {
	background-color: lightblue;
	border-radius: 0.50rem;
	border: 1px solid transparent;
}
</style>

<script>
	var xhttp = new XMLHttpRequest();
	var RazorpayOrderId;
	function CreateOrderID() {
		xhttp.open("GET", "http://localhost:8080/ShopApp/OrderCreation", false);
		xhttp.send();
		RazorpayOrderId = xhttp.responseText;
		OpenCheckout();
	}
</script>


<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
	function OpenCheckout() {
		var options = {
			"key" : "rzp_test_E9G49oUv0GH2vs",
			"amount" : "100",
			"currency" : "INR",
			"name" : "Acme Corp",
			"description" : "Test Transaction",
			"image" : "https://example.com/your_logo",
			"order_id" : RazorpayOrderId,
			"callback_url" : "http://localhost:8080/ShopApp/OrderCreation",
			"handler" : function(response) {
				console.log(response.razorpay_payment_id);
				console.log(response.razorpay_order_id);
				console.log(response.razorpay_signature)
			},
			"prefill" : {
				"name" : "Bhargav Bandi",
				"email" : "bhargav4brave@gmail.com",
				"contact" : "8688431120"
			},
			"notes" : {
				"address" : "Razorpay Corporate Office"
			},
			"theme" : {
				"color" : "#3399cc"
			}
		};

		var rzp1 = new Razorpay(options);
		rzp1.on('payment.failed', function(response) {
			alert(response.error.code);
			alert(response.error.description);
			alert(response.error.source);
			alert(response.error.step);
			alert(response.error.reason);
			alert(response.error.metadata.order_id);
			alert(response.error.metadata.payment_id);
		});
		rzp1.open();
		e.preventDefault();
	}
</script>

</head>
<body>

	<header>
		<h1>Your Shopping Cart</h1>
		<nav>
			<ul>
				<li><a href="home.jsp" class="button">Continue Shopping</a></li>
				<li>
					<form action="clear-cart" method="get">
						<button type="submit" class="button">Clear cart</button>
					</form>
				</li>
			</ul>
		</nav>
	</header>


	<main>
		<section class="cart">
			<table border="1">
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Price</th>
					</tr>
				</thead>
				<tbody>
					<%
					Cart cart = (Cart) session.getAttribute("cart");
					if (cart != null && !cart.getItems().isEmpty()) {
						for (Product item : cart.getItems()) {
					%>
					<tr>
						<td><%=item.getPname()%></td>
						<td><%=item.getPprice()%></td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="2">Your cart is empty.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<div class="total">
				<p>
					Total:
					<%=cart != null ? cart.getTotal() : 0.0%></p>
			</div>
		</section>
	</main>
	<center>
		<div>
			<button id="payButton" onclick="OpenCheckout()" class="bttnStyle">Pay
				Now</button>
		</div>
	</center>

</body>
</html>
