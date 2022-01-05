import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/product_detail_page.dart';
import 'package:shopapp/pages/products_page.dart';
import 'package:shopapp/utils/app_routes.dart';
import 'models/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepOrange.shade400,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
