import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/Api.dart';

class Orders extends StatelessWidget {
  final String? userId; // User ID parameter

  const Orders({super.key, required this.userId}); // Pass userId to widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Your Orders",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Api().fetchOrderDetails(userId!.toString()), // Pass userId to API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Orders available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) { 
              var order = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 218, 196),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID: ${order['order_id']}", style: TextStyle(fontSize: 16, color: Colors.black),),
                              Text("Customer Name: ${order['customerName']}", style: TextStyle(fontSize: 16, color: Colors.black),),
                              Text("Contact Number: ${order['phone']}", style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),),  
                              Text("Order Date: ${order['orderPlacedDate']}", style: TextStyle(fontSize: 14, color: Colors.black),),
                              Text("Address: ${order['address']}", style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),),
                          
                              Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(Icons.done_outline_rounded, color: Colors.green,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text("Paid -", style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("RS. ${order['price']}", style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),),
                                ],
                              ),
                          ),
                            ],
                          ),
                        ),
                    
                        
                    
                    
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
