import 'package:flutter/material.dart';
import 'package:online_shopping_app/components/Cart_Item.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height/1,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: Text("Cart", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 20,),
                          
                  CartItem(imgUrl: 'assets/Images/image3.png', category: 'Blouse', color: 'red', size: 'L', price: 2000,),
                  SizedBox(
                    height: 10,
                  ),
                  CartItem(imgUrl: 'assets/Images/image4.png', category: 'Frock', color: 'blue', size: 'XL', price: 3200),
                  SizedBox(
                    height: 10,
                  ),
                  CartItem(imgUrl: 'assets/Images/image5.png', category: 'Saree', color: 'mix', size: 'Free', price: 5400),
                  SizedBox(
                    height: 10,
                  ),
                  CartItem(imgUrl: 'assets/Images/image6.png', category: 'Little Frock', color: 'Purple', size: 'M', price: 2400),
                                  SizedBox(
                  height: 10,
                ),
                CartItem(imgUrl: 'assets/Images/image5.png', category: 'Saree', color: 'mix', size: 'Free', price: 5400)
                
                ]
                            ),
              ),
            ),

            

            GestureDetector(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.only(top: 610),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: Rs. 14000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        onPressed: (){
                  
                        },
                        child: Text("Checkout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),),)
                    ],
                  ),
                )
              ),
            )
            

          ],
        ),
      )
    );
  }
}