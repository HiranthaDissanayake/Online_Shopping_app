import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/pages/item.dart';

class Sareepage extends StatefulWidget {
  const Sareepage({super.key});

  @override
  State<Sareepage> createState() => _SareepageState();
}

class _SareepageState extends State<Sareepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.8,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/Images/image5.png",
                    fit: BoxFit.contain,
                    width: 150,
                    height: 180,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Here",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Our New Sarees",
                        style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Collection",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        "assets/Images/arrow.png",
                        fit: BoxFit.contain,
                        width: 50,
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: Api().fetchSarees(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No sarees available'));
                }

                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items in a row
                    crossAxisSpacing: 10, // Spacing between columns
                    mainAxisSpacing: 10, // Spacing between rows
                    childAspectRatio: 0.8, // Adjusts height of grid items
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var saree = snapshot.data![index];

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Item(item: saree,)));
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 250, 176, 176),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: saree['imageUrl'] != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                        imageUrl: saree['imageUrl'],
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 30,
                                        placeholder: (context, url) =>
                                            Center(
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: CircularProgressIndicator()),
                                            ),
                                        errorWidget: (context, url, error) => Icon(
                                            Icons.image_not_supported,
                                            size: 80),
                                      ),
                                  )
                                  : Icon(Icons.image_not_supported, size: 80),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    saree['name'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Color: ${saree['color']}',
                                    textAlign: TextAlign.center,
                                  ),
                                
                                  Text(
                                    'Rs. ${saree['price']}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: const Color.fromARGB(255, 3, 110, 7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
