import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Hello Hirantha",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ]),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Container(
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 124, 50),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "30% off",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "For This April",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                    child: Text(
                                  "Shop Now",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              )
                            ],
                          ),
                        ]),
                    Image.asset(
                      "assets/Images/image1.png",
                      fit: BoxFit.cover,
                      width: 200,
                      height: 220,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("see all", style: TextStyle(fontSize: 15, color: Colors.deepOrange),),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 221, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            
                SizedBox(
                  width: 20,
                ),
            
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 221, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            
                SizedBox(
                  width: 20,
                ),
            
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 221, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                 SizedBox(
                  width: 20,
                ),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 221, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
