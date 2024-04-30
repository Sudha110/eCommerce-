<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PaymentGateway</title>
</head>
<script type="text/javascript" src="https://checkout.razorpay.com/v1/razorpay.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
  // Single instance on page.
  var razorpay = new Razorpay({
    key: 'rzp_test_tCLhPLootU4w3M',
    // logo, displayed in the payment processing popup
    image: 'https://i.imgur.com/n5tjHFD.png',
  });

  // Fetching the payment.
  razorpay.once('ready', function(response) {
    console.log(response.methods);
  });

  // Submitting the data.
  var data = {
    amount: totalCost * 100, // in currency subunits. Here 1000 = 1000 paise, which equals to ₹10
    currency: "INR", // Default is INR. We support more than 90 currencies.
    email: 'test.appmomos@gmail.com',
    contact: '9123456780',
    notes: {
      address: 'Ground Floor, SJR Cyber, Laskar Hosur Road, Bengaluru',
    },
    // order_id: '123',
    method: 'netbanking',
    // method specific fields
    bank: 'HDFC'
  };

  $("#razorGateway").click(function() {
    alert("Payment clicked");
    // has to be placed within a user-initiated context, such as click, in order for popup to open.
    razorpay.createPayment(data);

    razorpay.on('payment.success', function(resp) {
      alert("Payment success.");
      alert(resp.razorpay_payment_id);
      alert(resp.razorpay_order_id);
      alert(resp.razorpay_signature);
    }); // will pass payment ID, order ID, and Razorpay signature to success handler.

    razorpay.on('payment.error', function(resp) {
      alert(resp.error.description);
    }); // will pass error object to error handler
  });
});
</script>
<body>
  <input type="button" id="razorGateway" name="submit" class="submit action-button" value="Pay" />
</body>