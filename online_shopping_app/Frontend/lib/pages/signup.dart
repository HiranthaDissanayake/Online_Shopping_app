import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/components/bottomNavBar.dart';
import 'package:online_shopping_app/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String userName = "";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                   Colors.deepOrange,
                  Colors.orangeAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            ),
          ),
      
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/3,),
            height: MediaQuery.of(context).size.height/1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text("REGISTER", style: TextStyle(fontSize: 30, color: Colors.black),),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please enter username";
                          }
                          return null;
                        }
                        ,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            prefixIcon: Icon(Icons.person, color: Colors.deepOrange,)),
                      ),
                    ),
                     SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          }

                          if (!value.contains("@gmail.com")){
                              return "Please enter valid email";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            prefixIcon: Icon(Icons.email, color: Colors.deepOrange,)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }

                          if(value.length <= 4){
                            return "Password should be at least 5 characters long";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.deepOrange),
                          prefixIcon: Icon(Icons.lock, color: Colors.deepOrange,),
                        )
                      )
                    ),
                    SizedBox(height: 20,),

                  
                    SizedBox(height: 20,),
                  
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(300, 50),
                        ),
                        child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20),),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){

                            var Data = {
                              "name" : _usernameController.text,
                              "email" : _emailController.text,
                              "password" : _passwordController.text
                            };

                            // Pass the Data map to Api 
                            Api.registerUser(Data, context);

                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login(userName: _usernameController.text)));
                          }
                          
                        },
                      ),
                    ),
                  
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("If you already have an account?", style: TextStyle(color: Colors.black),),
                        TextButton(
                          onPressed: (){
                            

                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login(userName: _usernameController.text)));
                          },
                          child: Text("Login", style: TextStyle(color: Colors.deepOrange),),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
          ),
      
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Center(child: Image.asset("assets/Images/logo1.png",fit: BoxFit.cover, width: 250,)),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}