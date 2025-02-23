import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/stripe_services.dart';
import 'package:online_shopping_app/pages/order_details.dart';
import 'package:provider/provider.dart';
import 'package:online_shopping_app/Provider/cartProvider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
                      return ListTile(
                        leading: Image.network(item["imageUrl"],
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item["name"]),
                        subtitle:
                            Text("Rs. ${item["price"]} x ${item["quantity"]}"),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_shopping_cart_outlined, color: Colors.red),
                          onPressed: () {
                            cartProvider.removeFromCart(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Total:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Rs. ${cartProvider.totalPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 10,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetails()));

                              },
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
