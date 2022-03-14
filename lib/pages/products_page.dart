import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/app_drawer.dart';
import 'package:shopapp/components/product_item.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    Future<void> _refreshProducts(BuildContext context) {
      return Provider.of<ProductList>(
        context,
        listen: false,
      ).loadProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerencir Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(products.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
