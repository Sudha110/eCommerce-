package com.shopApp.product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;

/**
 * Servlet implementation class OrderCreationServlet
 */
@WebServlet("/OrderCreation")
public class OrderCreationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrderCreationServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Order creation
		
		RazorpayClient client = null;
		String orderId = null;
		try {
			client = new RazorpayClient("rzp_test_E9G49oUv0GH2vs", "pXZ5dHXiHAyUK5BsP5NHS7SV");

			JSONObject options = new JSONObject();
			options.put("amount", "100");
			options.put("currency", "INR");
			options.put("receipt", "zxr456");
			options.put("payment_capture", true);
			Order order = client.Orders.create(options);
			orderId = order.get("id");
		} catch (RazorpayException e) {
			// TODO Auto-generated catch block.
			e.printStackTrace();
		}
		response.getWriter().append(orderId);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Signature Verification
		RazorpayClient client = null;
		try {
			client = new RazorpayClient("rzp_test_E9G49oUv0GH2vs", "pXZ5dHXiHAyUK5BsP5NHS7SV");
			JSONObject options = new JSONObject();
			options.put("razorpay_payment_id", request.getParameter("razorpay_payment_id"));
			options.put("razorpay_order_id", request.getParameter("razorpay_order_id"));
			options.put("razorpay_signature", request.getParameter("razorpay_signature"));
			
			String Secret = "pXZ5dHXiHAyUK5BsP5NHS7SV";
			boolean SigRes= Utils.verifyPaymentSignature (options, Secret);
		if (SigRes) {
		response.getWriter().append("Payment successful and Signature Verified");
		}else {
		response.getWriter().append("Payment failed and Signature not Verified");
		}
		} catch (RazorpayException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
	}
}
