import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/pages/item.dart';

class NewArrivals extends StatefulWidget {
  const NewArrivals({super.key});

  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text('New Arrivals', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        
      ),

      body: FutureBuilder(
        future: Api().fetchNewArrivals(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'),);
          }else if(!snapshot.hasData || snapshot.data == null){
            return Center(child: Text('No New Arrivals'),);
          }

          return GridView.builder(
          padding: EdgeInsets.all(10),
           itemCount: snapshot.data!.length,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items in a row
                    crossAxisSpacing: 10, // Spacing between columns
                    mainAxisSpacing: 10, // Spacing between rows
                    childAspectRatio: 0.6, // Adjusts height of grid items
                  ),
            itemBuilder: (context, index){
              var newArrival = snapshot.data![index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Item(item: newArrival)));
                },
                child: Card(
                          color: const Color.fromARGB(255, 219, 208, 249),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: newArrival['imageUrl'] != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                          imageUrl: newArrival['imageUrl'],
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
                                      newArrival['name'],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Color: ${newArrival['color']}',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Size: ${newArrival['size']}',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Rs. ${newArrival['price']}',
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
        }),
    );
  }
}