import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/pages/cartPage.dart';
import 'package:online_shopping_app/pages/home.dart';
import 'package:online_shopping_app/pages/profile.dart';

class Bottomnavbar extends StatefulWidget {

  String? userID;

   Bottomnavbar({
    super.key,
    required this.userID
    });

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {

  int currentTabIndex = 0;

  late List<Widget> pages = [
    Home(email: widget.userID.toString(),),
    CartPage(),
    Profile()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepOrange,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items:[
          Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.white,
          ),

          Icon(
            Icons.shopping_cart_outlined,
            size: 30,
            color: Colors.white,
          ),

          Icon(
            Icons.person_outline_rounded,
            size: 30,
            color: Colors.white,
          ),
        ]
        
      ),

      body: pages[currentTabIndex],
    );
  }
}