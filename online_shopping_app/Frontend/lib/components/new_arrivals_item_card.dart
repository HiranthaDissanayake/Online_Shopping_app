import 'package:flutter/material.dart';
import 'package:online_shopping_app/pages/item.dart';

class NewArrivalsItemCard extends StatefulWidget {
  const NewArrivalsItemCard({super.key});

  @override
  State<NewArrivalsItemCard> createState() => _NewArrivalsItemCardState();
}

class _NewArrivalsItemCardState extends State<NewArrivalsItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Item(item: {},) ));
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFFEB249),
          borderRadius: BorderRadius.circular(20),
        ),
      
        child: Stack(
          children: [
            Center(child: Image.asset("assets/Images/image3.png", fit: BoxFit.contain,width: 200)),
      
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                      child: Center(child: Text("Blouse", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),))),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black
                      ),
                      child: Center(child: Text("Rs.2000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),))),
                  ],
                ),
              ],
            ),
          ),
      
          ], 
        ),
      ),
    );
  }
}