import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,),
            ),

            Center(
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFFDEC0)
                ),
                child: Image.asset("assets/Images/image3.png", fit: BoxFit.contain,width: 200,))
            ),

            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Blouse", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Text(
                    textAlign: TextAlign.center,
                    "30% discount", style: TextStyle(fontSize: 15, color: Colors.red,),),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rs. 2000", style: TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.bold),),

                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(_count > 1){
                            _count--;
                          } 
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 255, 73, 18)
                        ),
                        child: Center(child: Icon(Icons.remove, color: Colors.white,),),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(_count.toString(), style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _count++;
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 255, 73, 18)
                        ),
                        child: Center(child: Icon(Icons.add, color: Colors.white,),),
                      ),
                    ),
                  ],
                ),

                


              ],
            ),

            SizedBox(
              height: 20,
            ),

            Text("Color", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red
                  ),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue
                  ),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black
                  ),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 249, 190, 29)
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            Text("Size", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),

            SizedBox(
              height: 10,
            ),


            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 209, 207, 207)
                  ),
                  child: Center(child: Text("XL", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),)),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 209, 207, 207)
                  ),
                  child: Center(child: Text("L", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),)),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 209, 207, 207)
                  ),
                  child: Center(child: Text("M", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),)),
                ),
                SizedBox(
                  width: 10,
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 209, 207, 207)
                  ),
                  child: Center(child: Text("S", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),)),
                ),
              ],
            ),

            SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: (){
                
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Text("Add To Cart", style: TextStyle(fontSize: 17, color: Colors.white),),
                          Spacer(),
                          Icon(Icons.add_shopping_cart_outlined, color: Colors.white,size: 23,)
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 170,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: (){
                
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Buy Now", style: TextStyle(fontSize: 17, color: Colors.white),),
                          SizedBox(width: 8),
                          Icon(Icons.payment, color: Colors.white,size: 23,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}