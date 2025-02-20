import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/components/category_option.dart';
import 'package:online_shopping_app/pages/categories/all_products.dart';
import 'package:online_shopping_app/pages/categories/blouses_page.dart';
import 'package:online_shopping_app/pages/categories/frocks_page.dart';
import 'package:online_shopping_app/pages/categories/kids_page.dart';
import 'package:online_shopping_app/pages/categories/saree_page.dart';
import 'package:online_shopping_app/pages/item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Text(
                      "Red",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      "Dress",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Image.asset(
                      "assets/Images/logo.png",
                      width: 60,
                      height: 60,
                    ),
                  ],
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
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6F00),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Best Prices",
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "assets/Images/image1.png",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.48,
                            height: 220,
                          ),
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
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllProductsPage()));
                      },
                      child: Text(
                        "see all",
                        style:
                            TextStyle(fontSize: 15, color: Colors.deepOrange),
                      )),
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
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlousesPage()));
                        },
                        child: CategoryOption(
                          imgUrl: "assets/Images/image3.png",
                          title: 'Blouses',
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Frockspage()));
                        },
                        child: CategoryOption(
                          imgUrl: "assets/Images/image4.png",
                          title: 'Frocks',
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sareepage()));
                        },
                        child: CategoryOption(
                          imgUrl: "assets/Images/image5.png",
                          title: 'Sarees',
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Kidspage()));
                        },
                        child: CategoryOption(
                          imgUrl: "assets/Images/image6.png",
                          title: 'Kids Dresses',
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Arrivals",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(fontSize: 15, color: Colors.deepOrange),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 200,
                  child: FutureBuilder(
                      future: Api().fetchNewArrivals(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No blouses available'));
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){

                            var newItem = snapshot.data![index];

                            return ListTile(
                              title: Text(newItem['name']),
                              subtitle: Text(newItem['price']),
                            );

                          }
                          
                           );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

//  PageView.builder(
//                 itemCount: 10,
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   Future.delayed(Duration(seconds: 2), () {
//                     if (index < 9) {
//                       _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
//                     } else {
//                       _pageController.jumpToPage(0);
//                     }
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 30),
//                     child: NewArrivalsItemCard(),
//                   );
//                 },
//               ),
