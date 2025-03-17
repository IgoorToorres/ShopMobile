import 'package:flutter/material.dart';
import 'package:shop/components/appbar_default.dart';
import 'package:shop/components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(
        title: 'Pagina inicial',
      ),
      body: ProductGrid(),
    );
  }
}