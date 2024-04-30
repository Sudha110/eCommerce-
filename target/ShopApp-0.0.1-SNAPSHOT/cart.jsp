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
<!-- Adjust the path accordingly -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
	<div class="total">
		<p>
			Total:
			<%=cart != null ? cart.getTotal() : 0.0%></p>

		<form id="razorpay-form">
			<button type="button" onclick="submitRazorpayForm()">Pay Now</button>
		</form>
	</div>
</body>
<script>
    // Function to submit the Razorpay form
    function submitRazorpayForm() {
        // Make an AJAX request to the server to get the order ID
        fetch('GetOrderIdServlet') // Update the servlet URL accordingly
            .then(response => response.text())
            .then(orderId => {
                // Initialize Razorpay button
                var options = {
                    key: 'rzp_test_E9G49oUv0GH2vs',
                    amount: <%=(cart != null ? cart.getTotal() : 0.0) * 100%>, // Amount in paise
                    currency: 'INR',
                    name: 'Your Online Shopping',
                    description: 'Payment for your order',
                    image: 'path_to_your_logo.png', // Replace with your logo URL
                    order_id: orderId, // Use the order ID obtained from the server
                    handler: function (response) {
                        // Handle the success response, typically update the order status
                        console.log(response);
                    },
                    theme: {
                        color: '#3399cc'
                    }
                };

                var rzp = new Razorpay(options);
                rzp.open();
            })
            .catch(error => console.error('Error fetching order ID:', error));
    }
</script>
</html>
