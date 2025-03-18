import 'package:flutter/material.dart';
import 'package:shop/data/dummyData.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyData;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  void addProducts(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
