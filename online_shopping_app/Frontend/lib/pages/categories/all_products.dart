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
  TextEditingController searchController = TextEditingController();
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<dynamic> products = await Api().fetchProducts();
      
      // Sort products by name before searching
      products.sort((a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));

      setState(() {
        allProducts = products;
        filteredProducts = products;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  // Binary Search function
  List<dynamic> binarySearch(String query) {
    int left = 0;
    int right = allProducts.length - 1;
    List<dynamic> results = [];

    while (left <= right) {
      int mid = (left + right) ~/ 2;
      String midName = allProducts[mid]['name'].toLowerCase();

      if (midName.contains(query.toLowerCase())) {
        // Find all matches in both directions
        int i = mid;
        while (i >= 0 && allProducts[i]['name'].toLowerCase().contains(query.toLowerCase())) {
          results.add(allProducts[i]);
          i--;
        }
        i = mid + 1;
        while (i < allProducts.length && allProducts[i]['name'].toLowerCase().contains(query.toLowerCase())) {
          results.add(allProducts[i]);
          i++;
        }
        break;
      } else if (query.toLowerCase().compareTo(midName) < 0) {
        right = mid - 1; // Search left side
      } else {
        left = mid + 1; // Search right side
      }
    }
    
    return results;
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = allProducts;
      });
      return;
    }

    setState(() {
      filteredProducts = binarySearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          'All Products',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search for products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: Text("No products found"))
                : ListView(
                    children: [
                      _buildProductSection('Blouses', filteredProducts.where((p) => p['type'] == 'blouse').toList()),
                      _buildProductSection('Frocks', filteredProducts.where((p) => p['type'] == 'frock').toList()),
                      _buildProductSection('Sarees', filteredProducts.where((p) => p['type'] == 'saree').toList()),
                      _buildProductSection('Kids', filteredProducts.where((p) => p['type'] == 'kid').toList()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(String title, List<dynamic> products) {
    if (products.isEmpty) return SizedBox(); // Hide empty categories

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
