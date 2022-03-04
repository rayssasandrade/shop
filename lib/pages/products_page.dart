import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/app_drawer.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerencir Produtos'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCout,
          itemBuilder: (ctx, i) => Text(products.items[i].title),
        ),
      ),
    );
  }
}
