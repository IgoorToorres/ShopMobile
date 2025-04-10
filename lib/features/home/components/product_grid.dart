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

    return Container(
      // Você pode definir uma cor de fundo sutil:
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(), 
          itemCount: loadedProducts.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: loadedProducts[i],
            child: const ProductGridItem(),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            // proporção levemente mais vertical para evidenciar a imagem
            childAspectRatio: 0.72,
          ),
        ),
      ),
    );
  }
}
