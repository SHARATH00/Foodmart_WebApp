package com.project.freshpicks.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.freshpicks.Controller.pojo.ApiResponse;
import com.project.freshpicks.JWTToken.ShoppingCartCheck;
import com.project.freshpicks.model.Cart;
import com.project.freshpicks.model.CheckoutCart;
import com.project.freshpicks.service.AddtoCartService;
import com.project.freshpicks.service.impl.ProductServices;

@RestController
@RequestMapping("api/order")
public class OrderController {
	@Autowired
	AddtoCartService cartService;
	ProductServices proService;

	@RequestMapping("checkout_order")
	@CrossOrigin
	public ResponseEntity<?> checkout_order(@RequestBody HashMap<String, String> addCartRequest) {
		try {
			String keys[] = { "email" };
			if (ShoppingCartCheck.validationWithHashMap(keys, addCartRequest)) {

			}
			String email = addCartRequest.get("email");
			List<Cart> cartItems = cartService.getCartByUserId(email);
			List<CheckoutCart> tmp = new ArrayList<CheckoutCart>();
			for (Cart addCart : cartItems) {
				String orderId = "" + getOrderId();
				CheckoutCart cart = new CheckoutCart();
				cart.setEmail(email);
				cart.setOrder_id(orderId);
				cart.setProduct(addCart.getProduct());
				cart.setQty(addCart.getQty());
				tmp.add(cart);

			}
			cartService.saveProductsForCheckout(tmp, email);
			return ResponseEntity.ok(new ApiResponse("Order placed successfully", ""));

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body(new ApiResponse(e.getMessage(), ""));
		}
	}

	public int getOrderId() {
		Random r = new Random(System.currentTimeMillis());
		return 10000 + r.nextInt(20000);
	}

	@RequestMapping("getOrdersByUserId")
	@CrossOrigin
	public ResponseEntity<?> getOrdersByUserId(@RequestBody HashMap<String, String> ordersRequest) {
		try {
			String keys[] = { "userId" };
			return ResponseEntity.ok(new ApiResponse("Order placed successfully", ""));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body(new ApiResponse(e.getMessage(), ""));
		}

	}
}