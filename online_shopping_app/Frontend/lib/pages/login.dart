import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_shopping_app/Models/userModel.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/components/bottomNavBar.dart';
import 'package:online_shopping_app/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isApiCallProccess = false;
  bool hidePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        padding: const EdgeInsets.only(top: 80),
                        child: Text("LOGIN", style: TextStyle(fontSize: 30, color: Colors.black),),
                      ),
                      SizedBox(height: 40,),
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
                            if(value!.isEmpty) {
                              return "Please enter password";
                            }
                          },
                          obscureText: hidePassword ? true : false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            prefixIcon: Icon(Icons.lock, color: Colors.deepOrange,),
                          )
                        )
                      ),
                      SizedBox(height: 20,),
                    
                      TextButton(
                        onPressed: (){
                      
                        },
                        child: Text("Forgot Password?", style: TextStyle(color: Colors.deepOrange),),
                      ),
                    
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
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),),
                          onPressed: (){
                            if(_formkey.currentState!.validate()){

                              var enteredData = {
                                "email" : _emailController.text,
                                "password" : _passwordController.text
                              };

                              Api.login(enteredData, context);

                              _emailController.clear();
                              _passwordController.clear();

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavbar()));
                            }
                            
                          },
                        ),
                      ),
                    
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: TextStyle(color: Colors.black),),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                            },
                            child: Text("Sign Up", style: TextStyle(color: Colors.deepOrange),),
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