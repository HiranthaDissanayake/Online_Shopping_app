import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/Services/Api.dart';
import 'package:online_shopping_app/pages/item.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text('All Products',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Api().fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          // Categorize products by type
          final products = snapshot.data!;
          final blouses = products.where((p) => p['type'] == 'blouse').toList();
          final frocks = products.where((p) => p['type'] == 'frock').toList();
          final sarees = products.where((p) => p['type'] == 'saree').toList();
          final kids = products.where((p) => p['type'] == 'kid').toList();

          return ListView(
            children: [
              _buildProductSection('Blouses', blouses),
              _buildProductSection('Frocks', frocks),
              _buildProductSection('Sarees', sarees),
              _buildProductSection('Kids', kids),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductSection(String title, List<dynamic> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Item(item: product),
                  ),
                );
              },
              child: Card(
                color: const Color.fromARGB(255, 219, 208, 249),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: product['imageUrl'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: product['imageUrl'],
                                fit: BoxFit.cover,
                                width: 200,
                                height: 30,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                ),
                              ),
                            )
                          : Icon(Icons.image_not_supported, size: 80),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Color: ${product['color']}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Size: ${product['size']}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Rs. ${product['price']}',
                            style: TextStyle(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 3, 110, 7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}