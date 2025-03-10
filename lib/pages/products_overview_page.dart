import 'package:flutter/material.dart';
import 'package:shop/components/appbar_default.dart';
import 'package:shop/components/product_item.dart';
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
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) {
          return ProductItem(product: loadedProducts[i]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
      ),
    );
  }
}
