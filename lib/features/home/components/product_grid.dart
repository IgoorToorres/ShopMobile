import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/home/components/product_grid_item.dart';
import 'package:shop/models/product/product.dart';
import 'package:shop/models/product/provider/product_provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid(this.showFavoriteOnly, {super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return Padding(
      padding: const EdgeInsets.all(16.0), // margem externa em torno da lista
      child: GridView.builder(
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: ProductGridItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
      ),
    );
  }
}
