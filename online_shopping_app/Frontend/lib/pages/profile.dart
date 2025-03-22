import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  String? userID;
   Profile({
    super.key,
    required this.userID
    
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                  ),
                  child: Column(children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 150, left: 8,right: 8),
                      child: Card(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/500),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Email : ', style: TextStyle(fontSize: 18, color: Colors.black),),
                              Text(userID.toString(), style: TextStyle(fontSize: 18, color: Colors.black),),
                            ]
                          )
                        ),
                      ),
                    )
                  ],)
                ),
              ),
            
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
                child: Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 11, 11, 10),
                    ),
                    child: Center(child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.person, size: 50, color: Colors.deepOrange,),
                      )),
                  ),
                ),
              )
              ],
               
            ),
          ],
        ),
      ),
    );
  }
}