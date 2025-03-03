import 'package:flutter/material.dart';
import 'package:online_shopping_app/Provider/cartProvider.dart';
import 'package:provider/provider.dart';

class Item extends StatefulWidget {
  final Map<String, dynamic> item;

  const Item({super.key, required this.item});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 234, 210),
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              Center(
                  child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFDEC0)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.item["imageUrl"],
                              fit: BoxFit.cover)))),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      widget.item["name"],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // Text(
                    //   textAlign: TextAlign.center,
                    //   "30% discount", style: TextStyle(fontSize: 15, color: Colors.red,),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs. ${widget.item["price"]}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_count > 1) {
                              _count--;
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 255, 73, 18)),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          _count.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _count++;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 255, 73, 18)),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: widget.item["color"] == "red"
                                  ? Colors.red
                                  : widget.item["color"] == "blue"
                                      ? Colors.blue
                                      : widget.item["color"] == "green"
                                          ? Colors.green
                                          : widget.item["color"] == "yellow"
                                              ? Colors.yellow
                                              : widget.item["color"] == "orange"
                                                  ? Colors.orange
                                                  : widget.item["color"] == "black"
                                                      ? Colors.black
                                                      : widget.item["color"] ==
                                                              "white"
                                                          ? Colors.white
                                                          : widget.item["color"] ==
                                                                  "pink"
                                                              ? Colors.pink
                                                              : widget.item[
                                                                          "color"] ==
                                                                      "purple"
                                                                  ? Colors.purple
                                                                  : widget.item[
                                                                              "color"] ==
                                                                          "brown"
                                                                      ? Colors.brown
                                                                      : widget.item[
                                                                                  "color"] ==
                                                                              "blend red"
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              120,
                                                                              12,
                                                                              4)
                                                                          : widget.item["color"] ==
                                                                                  "blend green"
                                                                              ? const Color.fromARGB(255, 3, 75, 5)
                                                                              : Colors
                                                                                  .transparent,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.item["color"],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          
                  SizedBox(
                    width: 30,
                  ),
          
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Size",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
          
                      SizedBox(
                        height: 10,
                      ),
          
                      Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 209, 207, 207),
                    ),
                    child: Center(
                        child: Text(
                      widget.item["size"],
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.item["size"] == "XL" ? "Extra Large" : widget.item["size"] == "L" ? "Large" : widget.item["size"] == "M" ? "Medium" : widget.item["size"] == "S" ? "Small" : widget.item["size"] == "F" ? "Free Size" : widget.item["size"], style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                  )
                    ],
                  ),
                  
          
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart({
                      "name": widget.item["name"],
                      "price": widget.item["price"],
                      "imageUrl": widget.item["imageUrl"],
                      "quantity": _count,
                    });
              
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added to Cart!"),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add To Cart",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.white,
                          size: 23,
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
    );
  }
}
