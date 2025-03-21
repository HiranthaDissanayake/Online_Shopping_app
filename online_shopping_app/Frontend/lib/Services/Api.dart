import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_app/components/bottomNavBar.dart';

class Api {

  static const baseUrl = "http://192.168.61.38:5001/api/";

  // POST API for register user

  static Future registerUser(Map<String, dynamic> userData , BuildContext context) async{

    print(userData);

    var url = Uri.parse("${baseUrl}add_user");

    try{
      final res = await http.post(
        url,
        headers: {"content-Type" : "application/json"},
        body: jsonEncode(userData),
      );

      if(res.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Registered Successfully"),
            duration: Duration(seconds: 5),
          )
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to Register User"),
            duration: Duration(seconds: 5),
          ),
        );
      }

    }catch(e){

    }
  }


  // GET API for login

  static Future login(Map<String, dynamic> userData, BuildContext context) async {

    print(userData);

    var url = Uri.parse("${baseUrl}login");

    try{

         final res = await http.post(
          url,
          headers: {"content-Type" : "application/json"},
          body: jsonEncode(userData),
        );

        if(res.statusCode == 200){


          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Logged Successfully"),
            )
          );

          Navigator.push(context, MaterialPageRoute(builder: (context)=> Bottomnavbar(userID: userData["email"])));

        } 
        
        if(res.statusCode == 401){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Not Found"),
              ),
              
          );
        }

        if(res.statusCode == 400){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Email and Password are required"),
            )
          );
        }

        if(res.statusCode == 500){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Data Error"),)
          );
        }

    }catch(e){

      print(e);
      
    }
  }


  // GET API for fetch all blouses

  Future<List<dynamic>> fetchBlouses() async {

  var url = Uri.parse("${baseUrl}blouses");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception('Failed to load blouses');
  }
}


  // GET API for fetch all frocks

  Future<List<dynamic>> fetchFrocks() async {

  var url = Uri.parse("${baseUrl}frocks");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception('Failed to load frocks');
  }
}


  // GET API for fetch all sarees

  Future<List<dynamic>> fetchSarees() async {

  var url = Uri.parse("${baseUrl}sarees");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception('Failed to load sarees');
  }
}


  // GET API for fetch all sarees

  Future<List<dynamic>> fetchKids() async {

  var url = Uri.parse("${baseUrl}kids");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception('Failed to load kids');
  }
}


// GET API for fetch all products

Future<List<dynamic>> fetchProducts() async {
  var url = Uri.parse("${baseUrl}products");

  final res = await http.get(url);

  if(res.statusCode == 200){
    return jsonDecode(res.body);
  }else{
    throw Exception(res.statusCode);
  }    
}


// GET API for fetch new arrivals

Future<List<dynamic>> fetchNewArrivals() async {

  var url = Uri.parse("${baseUrl}new_arrivals");

  final res = await http.get(url);

  if(res.statusCode == 200){
    return jsonDecode(res.body);
  }else{
    throw Exception(res.statusCode);
  }

}


// POST API for store order details

static Future storeOrder(Map<String, dynamic> orderDetails , BuildContext context) async {

  var url = Uri.parse("${baseUrl}orders");

  final res = await http.post(
    url,
    headers: {"content-Type" : "application/json"},
    body: jsonEncode(orderDetails),
  );

  if(res.statusCode == 200){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Order Saved"),
        duration: Duration(seconds: 3),
      )
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Order Not Saved , Try Again"),
        duration: Duration(seconds: 3),
      ),
    );
  }
}


// GET API for fetch order details

 Future<List<dynamic>> fetchOrderDetails(String userId) async {
    var url = Uri.parse("${baseUrl}userOrders/$userId"); // Ensure userId is passed

    print("Fetching orders from: $url");
    print("User ID: $userId"); // Debugging

    final res = await http.get(url);

    print("Response status: ${res.statusCode}"); // Debugging
    print("Response body: ${res.body}"); // Debugging

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load orders. Status code: ${res.statusCode}");
    }
  }


  // Get Api for find each user id

Future<String> fetchUserId(String email) async {
  print("Passed email: $email");
  
  var url = Uri.parse("${baseUrl}users/email/$email");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    var decodedBody = jsonDecode(res.body);
    
    var id = decodedBody["id"].toString(); // Convert to String

    print('User   ID: $id');

    return id; 
  } else {
    throw Exception("Failed to find user id. Status code: ${res.statusCode}");
  }
}

}