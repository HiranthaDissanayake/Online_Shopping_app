import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String imgUrl;
  final String category;
  final String color;
  final String size;
  final int price;
  const CartItem({
    super.key,
    required this.imgUrl,
    required this.category,
    required this.color,
    required this.size,
    required this.price,
    
    });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(widget.imgUrl, width: 100,),
              ),
      
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.category, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text(widget.color, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                  Text(widget.size, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                ],
              ),
      
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("Rs. ${widget.price}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  ),
      
                  SizedBox(
                    height: 5,
                  ),
      
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
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 255, 73, 18)
                          ),
                          child: Center(child: Icon(Icons.remove, color: Colors.white,size: 15,),),
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
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 255, 73, 18)
                          ),
                          child: Center(child: Icon(Icons.add, color: Colors.white,size: 15,),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      
      
            ],
          ),
        ),
    );
  }
}