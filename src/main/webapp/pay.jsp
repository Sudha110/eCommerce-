<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pay with RazorPay</title>
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
	<center>
		<div>
			<button id="payButton" onclick="OpenCheckout()" class="bttnStyle">Pay
				Now</button>
		</div>
	</center>

</body>
</html>