import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_app/Models/userModel.dart';
import 'package:online_shopping_app/pages/home.dart';

class Api {

  static const baseUrl = "http://192.168.239.38:5001/api/";

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

          Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));

        } else if(res.statusCode == 401){
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


}