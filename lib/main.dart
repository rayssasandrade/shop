import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:shopapp/pages/counter_page.dart';
import 'package:shopapp/pages/product_detail_page.dart';
import 'package:shopapp/pages/products_page.dart';
import 'package:shopapp/providers/counter.dart';
import 'package:shopapp/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => CounterPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
