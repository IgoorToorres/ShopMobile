import 'package:flutter/material.dart';
import 'package:shop/components/appbar_default.dart';
import 'package:shop/data/dummyData.dart';
import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyData;
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(
        title: 'Pagina inicial',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.network(
                    loadedProducts[i].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(loadedProducts[i].title),
              ],
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2,
          ),
        ),
      ),
    );
  }
}
