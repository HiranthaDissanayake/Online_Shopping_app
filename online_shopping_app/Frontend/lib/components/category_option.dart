// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryOption extends StatefulWidget {
  final String imgUrl ;
  String title ;

  CategoryOption({
    super.key,
    required this.imgUrl,
    required this.title
  });

  @override
  State<CategoryOption> createState() => _CategoryOptionState();
}

class _CategoryOptionState extends State<CategoryOption> {



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 235, 226),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imgUrl, width: 50),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}