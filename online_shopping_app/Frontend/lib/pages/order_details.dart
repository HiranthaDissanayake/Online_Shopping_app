import 'package:flutter/material.dart';
import 'package:online_shopping_app/Provider/cartProvider.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/Services/stripe_services.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          "Customer Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                    style: BorderStyle.solid)),
                            hintText: "Customer Name"),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter customer address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Contact Address"),
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _contactController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }

                          if (value.length != 10) {
                            return 'Please enter valid contact number';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Contact Number"),
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            helperText: "*Please enter email address only that you use to login",
                            helperStyle: TextStyle(fontSize: 13,color: Colors.red),
                            border: OutlineInputBorder(),
                            hintText: "Email address"),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _cityController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "City"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _zipCodeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter zip code';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Zip Code"),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Items Price : Rs. ${cartProvider.totalPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                    Text(
                      "Delivery Charges : Rs. 300",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Price : Rs. ${cartProvider.totalPrice + 300}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        bool paymentSuccess =
                            await StripePaymentService.processPayment(
                                cartProvider.totalPrice);

                        if (paymentSuccess) {

                          // create map to store delivery details
                          var deleveryDetails = {
                            "name": _nameController.text,
                            "address": _addressController.text,
                            "phone": _contactController.text,
                            "email": _emailController.text,
                            "city": _cityController.text,
                            "zip": _zipCodeController.text,
                            "price": cartProvider.totalPrice + 300,
                          };

                          // pass the delivery details to api
                          Api.storeOrder(deleveryDetails, context);


                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Payment Successful!"),
                                backgroundColor: Colors.green,
                                ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Payment Failed!")));
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pay Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.payment_outlined,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
